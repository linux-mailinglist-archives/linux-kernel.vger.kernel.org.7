Return-Path: <linux-kernel+bounces-843797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FBBC049B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A58E4F4849
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079CC21D59C;
	Tue,  7 Oct 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFQEo8u8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D521D3E2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816596; cv=none; b=OvDqMKV6nEVdkkSem+ab+1Q0mWWow1SfH165wi3cDCaKVFj8y1qObcZ11hTk8pgEri02f/BhriziBPd0YleM+ZFQEJB0JVhyaDiAgk6GgF4uHAuoPT29/z+XO8ZtIfbHDx3dfXr+dWTiu6ANXyyWWXUF+MMaonIr7iSlmDcgTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816596; c=relaxed/simple;
	bh=H19dVZQAvzTGNCf9cRaVWZQQIqzZENNgBWLT6yh9rho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkfNcprz696HF5xEbV/0QkV9dffYdaUZoos06jGs/IZVEZ6Sy17uppKYxPtg1aGSiDgSszlQE9kUD8+EllawWLCR+vMUVtp5Wz3U3Njnjps+zs4Hva2faiiEE/TiGMVl0faGKd/aR9j80Wb/O99L63DJ6H4WZ6nstoZyjybcB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFQEo8u8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7841da939deso5326601b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816594; x=1760421394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zze8JjQGVZ59f9v5sepoZK52dG/J61vT00o7vhqIkGY=;
        b=IFQEo8u8qL/nkBwp0/drwPuHxpUxr0gBPA+QGaPEMGZJOJJWKOYIp29AdLvBEx5lLF
         B/0hAzhZAOsziFAnapHNNO90vj/IsRhfmKbvITcpO27tynUymcgRnY8gM/phnCJ3lVdb
         pzKeTOc82X4mJbjNttuDEZE0WtGwpqdgWDbxVd7bEU8XsGfxbSRWJVEFIMy22ZvMldvb
         x9K6pEKIExIwCFYgrnMtLfN0syWzarchpgc5ESv86rhjudt9OBGSRVlG/Nx/S6ydHFja
         3/u3/wvXuGVuvzEQUCo4Rs6lBIsYe80HNm+1bvTV/FupruZuspYCdfdNqbWphNV3rqVM
         fOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816594; x=1760421394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zze8JjQGVZ59f9v5sepoZK52dG/J61vT00o7vhqIkGY=;
        b=fjL0X731hQ/DYmP/YzKC2pYJJE7GNZv7gGVjmgzt8wQx76XdF9naRVVQ1TQXb77zYh
         XIlgpDwGP1glskpVT4OYqm38tKjBrICSp0qb2En8cTmNmwnL4MN++7oTK46ofOVFZWHM
         KtmlU9RhIAvSINIXZLxhwVOs4qlYFAx8e6cl5XhdMaKZtadClJAJVvnouM3TmWhSbVwD
         x8XjO5lnAxZ3DM6sRSPjoHFdzWAW02/KeJNEpIl0g6mos+ZAJMrvlmr5J3cS/7C9mXbm
         uZfq3OfIpZn8+0XYtywtyECb3fvy1VL6F2ih/3u+blfxUrVCvmt7/+65DEq5xkX7K/Rd
         wxfw==
X-Forwarded-Encrypted: i=1; AJvYcCVuFCcTfldh4Dz9b1Q93Mdd0roWMVzi39GCTIzeUBrgoi9ZbLDsY1zfbhe+o5E36skWW4kIMcFmTReMV0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPP5HZ1TENjmWpCP9R8A8eW2oLg9tWISdijH6Cj/TANtTv1Mcj
	N9NVw/SbdKVC+Xm6rVK0ZFJR7XZUiwfidrEOxlJ9Kw/cMwMzAYAnvAKp
X-Gm-Gg: ASbGncs1vWGwsdft1sG+CUOdLkH4Tb/VZBrzq/7YKiPRf/xrMU1NQ9E0ghqVdN9tzRs
	sxzuKLEyUIWHR0zoStL8nLOBvg4DdzAmLNFHXIx1aJ41XyGyKa4Hnrd3x7XtBZY/ofYXn/UmTfM
	PwkhurOW+Qw97X5Ft+4228nUDZNa5vUQ7YwcnUKG1t/K+QmDeSBUzJvuGKVcPgNdcdwsOJrz+nR
	j4AGEr4FlkYAgD4vxIBuZhOCrBYHzYFDSBzu0Uz0zSrwedbfz1AgTeYhB2NtrGAAXRziSNfwagi
	c9R9Dx2h0RK3TsRg53XFiQ4JkWGp6hM7P4XX4SDp1i9iAzloodXPJ8cn3wFN8DK45Zmt8OZEYQ+
	j4fcH/ilQfP4+BdAlYCMdhh0Z0jX9FFRv/VovLnvlcSuNBwxbRN9cfxRNtVBwWhFZiyE5R9Dnwm
	J/27O7C/bnc8prsAwMV7FO9Z/j
X-Google-Smtp-Source: AGHT+IGJchkaRL43RoVbJQM3/xqF6zJKcQKtxGwtkcJ6fAH1ggss6t03FonlumhoWLdanF+7D9Tj0Q==
X-Received: by 2002:a17:903:987:b0:267:a95d:7164 with SMTP id d9443c01a7336-28e9a6b25a2mr170679085ad.60.1759816594138;
        Mon, 06 Oct 2025 22:56:34 -0700 (PDT)
Received: from [192.168.68.62] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1eee04sm148269865ad.130.2025.10.06.22.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 22:56:33 -0700 (PDT)
Message-ID: <467bd938-6fa4-46e7-9f98-d8d2a9e74eaa@gmail.com>
Date: Mon, 6 Oct 2025 22:56:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Upstreaming Pinephone Pro Patches
To: Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
 Martijn Braam <martijn@brixit.nl>, =?UTF-8?Q?Kamil_Trzci=C5=84ski?=
 <ayufan@ayufan.eu>, "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <49dafe9afc5962d8fec10e6135c9b84d@manjaro.org> <8606261.29KlJPOoH8@phil>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <8606261.29KlJPOoH8@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
> for reference for Rockchip dts files, the preferred format is:
> arm64: dts: rockchip: Do something on boardname
>
> aka "arm64: dts: rockchip: " and the rest is free form but should
> mention the board.
>
> But I'll generally fix those up myself if needed, so right now
> there is no need to resend just for that change.

Gotcha thanks! I'll leave this be for now while awaiting for comments on 
the mount matrix for the accelerometer and the magnetometer.


Rudraksha


