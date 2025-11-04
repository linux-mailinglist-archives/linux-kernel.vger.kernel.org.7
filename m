Return-Path: <linux-kernel+bounces-885564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E3C33556
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93AA18C4E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF9346FAC;
	Tue,  4 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nf3h5MV3"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3C336EC8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297622; cv=none; b=W89JpSBOykNlDN3nBlyhGj4gj9Y3MSAB4Ek+cYJMw4YuFaX9Mfs4DNDw/1/nEqO9Jlh3wrJCuve8TL0weghJIAkxYQQ7b2uDd+91ixAfAxIsHyLFSD76D+VMzG59bNGI0rninrxJMu9OyyoTmefUXnQUWhwECuZ7QPBzdtIs/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297622; c=relaxed/simple;
	bh=CsY4m5s2RMJkD3lvjeOF++mv47u/HIAkSzDbG5YyYFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OqrOwn0NgSjmHGQMh0/4VXm2YZMsfNXQPcYAnN3gZMR3OGoi8ycdxyvpTih1sTzTVYSyXBAuHzD6qQKapBiktgDSctQgIlIO4bzpp2LwwfRueLqNJncrmvXdtJ6vVZ/w7sVNWre9e/ksTN9y6WEoRk1fpjaOCiDozTlOF/8dv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nf3h5MV3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a1603a098eso3773883b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297619; x=1762902419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7rOk2SljDe8T4aO8i0PRNva7QDAcRd0Lww0kxlgSZQ=;
        b=Nf3h5MV3kq0+e7RI2TRSY/yX09WXLgN5TtiF3py68fUPDEfoNlXrgqlNGhhPl0Mr1Y
         1kZv/1dvM8+f6I8/yjDAgpDLJdNqO+hP0OJ+OazFUnStjli5WLaQOyaStql/UIhwvLhN
         k/OdXiVBOJRIuxqFr/SD8iepocR4ZlHrIT9o6c3JJ3VT7iYnoMWDfcz7/pDSM1Lnm3rN
         9/0BoBzb3wh74v7q1HV0OokX80JZzSijACcrBU0o3/0D0H1qhufR3ErOQ4afJcH2sMoZ
         vCHsJM1vsBMLuQP/dPF3CpvYrSKwHVtjh0a1tAL5PiqEA14EZYrE+JiZUD+lSmqEzzuQ
         aOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297619; x=1762902419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7rOk2SljDe8T4aO8i0PRNva7QDAcRd0Lww0kxlgSZQ=;
        b=mgrYakFNC5lwVLFD1YePVF3oofz7fCDcFXbQZ3mQZNR7Gp4SkAUVopBSWHIjQaWL+p
         tCVV4tgrVU55Tdm08BRn7mYo1o7X/fYPMOVRg6+RN4VUNaxaAQkn6Kztv7j/Eqa3La0F
         wdNH9XkflhWRZ3qRee63L5kXjFeknD5TihnqpfR3jFDBdGtwNiNRrIkAdp7Pm4LMYxWR
         UVTi1Pxu4Zb0H60KD0MOI60wjVrpzMghNIdN+TaVFfRbFRJez9jLwk8BGwES+kWb8egG
         Jfac8XFCpJpVA0U2WU5d4vERhLv5HTR4MqqN3Re2xguLx25OvgJP0yF9ngLLDH5KjJ3v
         9iiw==
X-Forwarded-Encrypted: i=1; AJvYcCUMJtkNn95CgDCfjuc+A+s9LvAOEx27WzqLfiLZMGrAFYdVe7AyzA6jfHygc357BvqkNYqZzfwtpvaT7G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZzjvbNoeQdtefCtrZAMK60q0XGZE6gpLn3fmuQn9V2vtx0Oy
	qq9+t2hUM80R735F6znY407Lj9LR/YPjq8ImXd4TYMsjoohEIZDbS47PdzErDqvgtb4UY5+qtcb
	ySYo1
X-Gm-Gg: ASbGnct/TgdE7DeTrqnJAm5AQwCHPzTDXjpS+lzFWG8AaJpjcsiJtFl+P4VrsBY1HOu
	79dxHwe6jc9d/Ld65Mjok0WRX7HuWGTYXg2NlFNYZsea7AJgeRba3fTqWDbSlykRK2V7+fPH9fb
	IKB7X5ubKP0DLIcBWNOiEuiYSWkHSLJ2HgTR3FmNLee/hgunZ2EnFXtpUa+oTpKFhuS6yRjYSyB
	C6/BcOG5UE84zBGUVp7aab9Rz2C4aOy0fWdy7Bd5kdy3Jm4Gpms1+WaGUtsEizymX7xK6q7trTY
	whsq9WtnDp0JxT4V8cc1G0KJWn8NXVz+WB46aD2kB/TUmwmkal91D3uoEESu/q1DlRfVIawTz5p
	rL1SKhPEauyoz/0h9fjOur+dLKXmtGnLPpt1I1WRwFT23tfPIUjWuDlf7WZwBRyFknbAzmwhy6Q
	==
X-Google-Smtp-Source: AGHT+IGLYp80GBLpwoYMtkxAs/l4LiwUD9QsWZrdQvRIeBfncu8inTEVtgBSRIphFP4oV2r+3SM7DQ==
X-Received: by 2002:a05:6a00:2d92:b0:7a1:68b2:5341 with SMTP id d2e1a72fcca58-7ae1d250dfemr1114563b3a.11.1762297619593;
        Tue, 04 Nov 2025 15:06:59 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5774c21sm4156649b3a.43.2025.11.04.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:06:59 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: andreas@kemnade.info, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, 
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-omap@vger.kernel.org
In-Reply-To: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
Subject: Re: (subset) [PATCH v8 0/3] dt-bindings: mfd: twl: Consolidate and
 fix TI TWL family bindings
Message-Id: <176229761865.2840692.9613824843684430886.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Sun, 14 Sep 2025 21:25:13 +0200, Jihed Chaibi wrote:
> Following extensive maintainer feedback, this patch implements the
> "define then disable" pattern. All possible child nodes are now defined
> at the top level. Conditional if/then blocks are used to explicitly
> disallow sub-modules that are not present on specific chip variants.
> 
> This refactoring also moves pre-existing sub-node definitions
> (e.g. madc, pwrbutton, gpadc, etc.) out of the conditional blocks
> to the top level, following the new pattern.
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
      commit: f7f3bc18300a230e0f1bfb17fc8889435c1e47f5
[3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
      commit: 3862123e9b56663c7a3e4a308e6e65bffe44f646

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


