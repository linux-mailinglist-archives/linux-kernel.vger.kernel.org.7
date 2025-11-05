Return-Path: <linux-kernel+bounces-887404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8712C38241
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A0A1A20063
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D32ECD2E;
	Wed,  5 Nov 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mauupxhK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D92ED848
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380410; cv=none; b=uk19rAIiuSQukZ6qYhRPRNwCcw2rlxYQM8ecmgTOyqS5DfUM+HhR0m8bZc1PRuABsJVyjUuBFxDAW+STCnfbvmX97iIBSMWazTIu6CbGtOxaOb/Jo5UkpdHiHatUpfEHE7/CC7RvWOqyRYJM8ASOCb1Uys1/jfIlU/LQzg9X9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380410; c=relaxed/simple;
	bh=SHOTNhnSxMeE28Gt8h+QmahNR+MdQ5fncUYSEMPwl2g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BTf6jsG2IKX1//hnxzwAcdUjUNlxss+stBjY52qxMV+vfcmmPUN/s/5AzLaMyE3fW27FdtdtPB0tDMVgAtHW+NMUS1TIPqw/Ksc3Z7YCz1AcOrYALHbCoDPZyMj/mnDd0sL8oDnVMUfeqnr2OXQfb5xi0Qwmu01K7JzMLo/5EXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mauupxhK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295548467c7so3489775ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762380407; x=1762985207; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBkyGpcDemQpY2M094SqDLojxus+6NpH3+OHJK4/jHI=;
        b=mauupxhKu2X5nVOip/SHS/ZiJFkwECjYVSkX7/T7o+JoCNk4VZv4dFeiY2Pt9qIZu+
         YbVsAsOpkwhnGK8d/SNImyjrAwrCUNFECKt4cz7cLH4OoT11kW4gVVILvPmd/8Ds7VR0
         cO3fgSfOI8bwIOlREs9CZ8BhiRdPz8HNBFzTIwCo3iAGVA9plrN53UjJRHH5h82pqWz0
         fq+h7bLffacpa/Fid5Fg/+V73CheWbIb/F5MeK5zar21l0UvQtD8LTJsDg+5iZ/3nUTb
         XdrKHZj4OzEEL3je5R5caOy9Z0loBi3BIp9gvgyVET71iA4D44KD5NLTU/1kTh/I+vTk
         8e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380407; x=1762985207;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBkyGpcDemQpY2M094SqDLojxus+6NpH3+OHJK4/jHI=;
        b=b3tEr1zD9Yn2/GTKQzGqk0kHNsYmUSLdIEQGEQ3LcocJHO/+xLYsnbmsArpeRFQotd
         ZsYhnSLZPoEC0n6lGJdXJUV41AgTrxJF0znvr+d3Vjozv1anhat78APBiGevm0FddV0A
         GthPIf/SHJjzSs9w9NAElNt0UQcW/jUVkSTc9FOdoBEscDr8CYUYMXLTa1K1uVq0sFdw
         kpT2UCnKrQFtSzfiGuvL49OgxkJ+0XKGtaPqwLPBrX1oVdgumDiQKEY5FfFcxSqLI4Ty
         iDatGCC/m8ldQDyohV6C/ZfokiS/jl6RhGEmF42TLELPzqNTXYBMvMOfBit2WEoQ5JRl
         k2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVIqwytJel+QGWSI+oYBT6f2SO7y6fmScD9XP1Q65b6IqQh1r0r1L2/BM7ReQT52mQDGafMnGJjrv2Lm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Deb5U3WMSrraIOi0ZivxL0ejjSjR5W9x9RSyY6Hew8oJzHsV
	EHauMiq7Y3QUimNwqNl51YY1wNzuZF2PtdDkMIcNkWvIHurq295exIA5iXoNiRVsapg=
X-Gm-Gg: ASbGncu4i1swdcRkJxM3ea6MKdUQuoSKKYx6aUz8x7vdciMad01yyzwndTaROot2wUa
	U6LwitY/HuziuRt4zCvFU8JEdyL7sBhGyG2DqwYTwm56BQ+QzO9BzDv2vOvMkBaRee2LknSiu6+
	JwGTl5QtjEMy5+sPOK4eblg8RfIClseDqG92gYezTyFjVEGWQwklE3THBtgEGnYaHue4OGtlVLe
	gmOWDL9/oqp6oPecduXQVhNg1kL2v7ttiFLPw6Kj4h1BP28hrTgO8z9QUC4SnmEA8xom7oI7Z/K
	8NAe0pD3c7YBUwgeU4JBHGaSCJGnaN/b8D7a0kBLgo9MjSHMyvIrbrQ6yaIKyKhZgN/hiCEi6Vj
	n11JkEng0dgg96qh3V/+4kGnoarvnXY0tW9u21qGXGOkLVdgiH7w5vkfoDyg8uof9CyxTKEyOQw
	==
X-Google-Smtp-Source: AGHT+IHXI8ToUsXPn1H/3Ag+W1Lf4830EcbI35NKWBjF1weadPXztynkJTg8EPbjmSTpnwucHe3dOA==
X-Received: by 2002:a17:902:ce90:b0:295:8da6:24b6 with SMTP id d9443c01a7336-2962adb1280mr71683995ad.40.1762380407441;
        Wed, 05 Nov 2025 14:06:47 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm5587205ad.11.2025.11.05.14.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:06:46 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, rogerq@kernel.org, tony@atomide.com,
 linux@armlinux.org.uk, tytso@mit.edu, lukas.bulwahn@redhat.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] arm: omap2plus_defconfig: enable ext4 directly
In-Reply-To: <176229761977.2840692.1048568589731485574.b4-ty@baylibre.com>
References: <20251013120753.101582-1-andreas@kemnade.info>
 <176229761977.2840692.1048568589731485574.b4-ty@baylibre.com>
Date: Wed, 05 Nov 2025 14:06:46 -0800
Message-ID: <7h7bw4i16x.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Hilman <khilman@baylibre.com> writes:

> On Mon, 13 Oct 2025 14:07:53 +0200, Andreas Kemnade wrote:
>> In former times, ext4 was enabled implicitely by enabling ext3 but with
>> the ext3 fs gone, it does not get enabled, which lets devices fail to
>> mount root on non-initrd based boots with an ext4 root.
>> 
>> 
>
> Applied, thanks!
>
> [1/1] arm: omap2plus_defconfig: enable ext4 directly
>       commit: 810c5ef6efe9a2be3203a50de781d9050e8b9920

I ended up dropping this patch because it conflicted with patches
already in Linus' tree

  c065b6046b34 ("Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs")

If this is still needed, please respin.

Kevin


