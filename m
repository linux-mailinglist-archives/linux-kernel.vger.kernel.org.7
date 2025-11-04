Return-Path: <linux-kernel+bounces-885565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36CC33541
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 782C334AE9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE8346A08;
	Tue,  4 Nov 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A3kDzrrK"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821A346A06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297622; cv=none; b=R+kQg0Mh/mujzRyk3/951CHJnAd6KJ/8pSad/HefxmTcb0pTJ+0mftVqzBQ14JpRr4cIqlXv+8FxVWK3W5XUGhV95kEApDckE+KI46kuxe1EKkHhRaoynqMJhg7J7cI/3IPWxoeL/Zv5EsnyceGUzJjvF/qOOE7m6vdEyNaQ3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297622; c=relaxed/simple;
	bh=+x1u7DsqDUclh/owaM/bK5voNKKcZglEj793Gh4GzMk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxQlOAam+lYLIPw1oM9cIuRnJcIy5GWtUVDtb/4RsCz1T2NrQZeCxJDY8tMKchoUlgUoPE65eQsSUKbK0kbHoYS2t91aPRWh0a0ZPsYFl1sWr9D944L4DgAA9NOUMPnXSVvvASRgqf0vzVEn9NPmExMIajQCothN3mrVu0lMxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A3kDzrrK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so302289b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297620; x=1762902420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHSamikVjrVol75rYdX/wA0TP+ZRoamzeKbRQET/Fto=;
        b=A3kDzrrKBAd+igP6DAPMYXIO0hAdOuNSFRt/eDGOCPHUgjCH2RT/NilhkgkpbwxXQ5
         ezRcvUrnfusG3H50Z1cPY/I0G+14CfiBz3TUj8UT99U+31NMl8MnSkYcEcEDyIrvZX3E
         qLMa2ge+jlffq4XaxDakgvMRxvlic91sDv7v9G/YbGULu78Fm5gk2rPOrCb/Zq1f/+4G
         S862r92ZIvWjO5MzpPpGawVlgjwctl2TcY6B47MFvumu446C0TG3J48eYggn7ZN4I8DK
         lnBpETodbBfNM2KfHTlKPJ5iTRlTFcdr9Nx6LU2cEeCyb2keVqrdWgvMOVIy+6WZsSga
         tOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297620; x=1762902420;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHSamikVjrVol75rYdX/wA0TP+ZRoamzeKbRQET/Fto=;
        b=fNaQ88JHVznVfp2ne3KZ3/tWStXF6bPiqiKV4cAL13ahliBpjO0NMLyL1Vxhjefx+g
         wXKFOsbfA8OYUVuhdP+NYgW2K/NMTNyatvyjklR/L++OjAIrHZIRCO9qUSJmjE9aa+oG
         NVQehVRffIAq073JasHembmzQWi+ZS1T3GUB6iA9a1Z7EEoK+W+4l7ptxTAp2ZXSoXQG
         CyQkTjvrYVFVmKWUDY297XC703mUaQggV0gu20gEfNOU9NIaIrd6NEGFNfiBEcvY88A5
         ANlgOL4gcGkRwTz7d6vlw5KD5ucDiepeGtj4/4KvDaYMC8Z9PeOHnjzRE+EohPRONhsm
         RM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMZpigQqtqhpfqiMlI0cWw/A39Y6Rz9GJEt3xCznCUsIh6OZKPFAKyaFaquCV/1DOddd7am6QWsAn267E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SjMWCa8OEYAklSNUafnELqJaha7MLWJZFq/Fflo7xH4//hD0
	/ekOl1k9veEA1cLe9ziZJmN1VO7czzEKt1I91DsFD4mmupjnVitY4KPO8vjJJ13dCy0=
X-Gm-Gg: ASbGncvSzaAYr2DvNCqsVLY+clPu33npaYQ8obry07x720LhuUvaEy5jD0J1UhY/Vu7
	fpwJ0kBNmeyUfHI6LizIEhdrO4XPjg34MoP0Y6txvoI+/GQ98CzlHDFoGRYDbLp7GGVJBEgaILo
	FlN4+Iho+W4JunVPkGcgHxYC1fmM55PvN+qj5LMyP6I84g/F7PCNlOp1S2FpZo0OALnUbULGmJ5
	KAYzpDNNMEqhgNY2+jiWn1ue/ed52D6P/i9rP3rbzR42WoFmGJg59/wLTTgJeDiCnp2lybGcs/+
	BZhmIMVRA+kLrr7RIeasGIn4TDbquNhFfTt0Zh+L/CXD8wtX0txd3sQAq0Fs9HjeEy7R7//ffNd
	Q9Xp5VQCTF6dTdizJAwcHuGgWPCdOaSQglcGrnxZS5my2ptd7Sr4cYiLavEMHqI1N+HTAIX1yxQ
	==
X-Google-Smtp-Source: AGHT+IFwaQTBRp6clVlgeUdPBLrNZliJRL42mTKXc1D1BNOKkI6h97kjY4cM1NfLKF6HAWHzWlKceA==
X-Received: by 2002:a05:6a20:9185:b0:342:c634:e272 with SMTP id adf61e73a8af0-34f729aa687mr1756746637.28.1762297620628;
        Tue, 04 Nov 2025 15:07:00 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd624030esm4104328b3a.53.2025.11.04.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:07:00 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, rogerq@kernel.org, tony@atomide.com, 
 linux@armlinux.org.uk, tytso@mit.edu, lukas.bulwahn@redhat.com, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20251013120753.101582-1-andreas@kemnade.info>
References: <20251013120753.101582-1-andreas@kemnade.info>
Subject: Re: [PATCH] arm: omap2plus_defconfig: enable ext4 directly
Message-Id: <176229761977.2840692.1048568589731485574.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Mon, 13 Oct 2025 14:07:53 +0200, Andreas Kemnade wrote:
> In former times, ext4 was enabled implicitely by enabling ext3 but with
> the ext3 fs gone, it does not get enabled, which lets devices fail to
> mount root on non-initrd based boots with an ext4 root.
> 
> 

Applied, thanks!

[1/1] arm: omap2plus_defconfig: enable ext4 directly
      commit: 810c5ef6efe9a2be3203a50de781d9050e8b9920

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


