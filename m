Return-Path: <linux-kernel+bounces-778695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F14B2E90B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3678A7A6067
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AD2E1749;
	Wed, 20 Aug 2025 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fcqu24aE"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21122E0939;
	Wed, 20 Aug 2025 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733991; cv=none; b=jfv9Gr+jexrpgStPx6Y5R/W0r/2LSkQyR8IBTm277fqDpXm03IINf8JBHETg1ZtxGRLamZp5j/V8L1UHRdw4nRxt5kCJjlqanp3nFp4CCLNcqacagOYLGRK295TtqPiXsOOXENoiDPijM7eiDUcQoTwGwfupHlVbqkimd3dkq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733991; c=relaxed/simple;
	bh=lkZhE+qJJqo4/9WGe2KQdl21djGJ/OVTnSNmbs7LToE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0n0VLiD00/FBmlPYLikFx/ldSIQVrS+Tb3GEnjyPWKFSfb7pD1YdxC4WkFlNYdFiGvic/gRfiU8OHJB8lLiy9KAi9Dc9sFhxK6wHt2AV37dVpkDOcPA6dskj116UdHO/ADQZzHui+7R9TrgXi9qwSaAebK8kulGE+kZdi8p0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fcqu24aE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so1106277a12.1;
        Wed, 20 Aug 2025 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755733989; x=1756338789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEIR/kzy6wy9KbvYVdpPt5IxnAmvBoijUDq7bSPssBE=;
        b=Fcqu24aEdIt/bbDbFB/zSkkuucwBAVQkgnVu6/Wwl3TfUoZaK3adXoVMAoJSFBryh5
         io4lr6eYD9UF5RxVPNYD7uRhdl8XqfXX+kARtsAUSLfIM8ICKBwSUkcx3vBipl31BP+a
         mVixl/4odcvQP4EOG1lEuJPWi+fqv7R9NekyezMtMXykN3nBAtNh2CVt+CAfmn+njOSs
         PwfpZsbvUl89hyGSkHtNbOfVm+/YDsKzynRpOGMbI6vUo4foNuBZzZu3ihlbi3nn90Rt
         KHiC1QHm9KWGXWjllplVUXfGHLrG78MbVIpd7cwNiZTtVSvk22DP1Lkevqg+xRSnK76w
         WgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733989; x=1756338789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEIR/kzy6wy9KbvYVdpPt5IxnAmvBoijUDq7bSPssBE=;
        b=V9uLbXrstRe7Lkojn62IJVwZ1TPMRuj9BtkRNcK08mA4EkbSLB78TqZJ4cGAtg8shD
         vqSFMc8pxBi/nL1st9dEbtSrT3s+OdDM4xm8DvZCq0SyALICbzm3llVOHNZOUed3B4o6
         Lt0q9/Nov1DWkwqhgIyWoHgonC928l5yoQjBZoxZ3MimCMzL+3ACTiO7FB546JRl7XPa
         o4Tqf240OKbmD4hkVUiREvNl7eH8JfwrKLgZRluPwgllUj8E8xy/NagP3sB1+chNSwCJ
         qGLehzsSel89Vkj42h2RX/nqO2IfqNTmFOTdshN8ZSfn84P5OdY9xauW+dHGAD/1V4A3
         NY8g==
X-Forwarded-Encrypted: i=1; AJvYcCWovk57rlyxyBCiLKSp8mcLcBAZ1es5JatpiziVo5EaE2Ar6GNk/PoISK/J/+2A7+jIajAKzlC1UGA=@vger.kernel.org, AJvYcCXCpUwkwVfEtcn1gCSJ96cBvC8A/UdicCBdNlrHtiIhtAtY0iF160Zh2xgXE5ZKRIUcpetJXXeAuWgHz2SZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyyF1FEa5k+pqiBiGhyRzxJ4boj1DvwzQIuqE6zL0DKByuNLyzn
	NZEjnaaT3R2hfxG6zMle20VQdskTTX2oTf1yxvLP71xaMv4Om0kb8qxae0l2Jw==
X-Gm-Gg: ASbGnctq5CL55kbfe12GPl4IG3Z8w1gk5JCx4o9PSNrpD5TV0d61A2vnlU1MJqtvxsQ
	t9WH54FrI4w6Oqaiu9F9PgZbZqquZDjY8Oeth2N0BxS4kkbzxK3Udn9c6kZKQjR3n9ZVdTCGh1j
	MkAPKj1ZN+DzuRUkaIRdXOpmvuGQezClzTTXtXTSuiUZhrE+ryl3ih3rDl6+4KCqC0+zYBBss87
	XpmmibZo4AAI3YlCLK8kMAtigpwPBUbIlcWwX2zmTETNrURqohAJQhjlTV1h9xLRMja43vUiNCf
	f0UXp3rMu444HaKiWNQ5/jvGjT+0QwGdMdVueRL/JJHWViSY/ONiU8kiULyk4SSzpZ+t1+OPkAp
	5sL/hF4SoFNsIzQabvlGvl2gJLhzzLfLdWykqPntAqxrYDJsoB/NhX1DQYaYDlux+jLe/
X-Google-Smtp-Source: AGHT+IGicx+inoO1VpDAFyKYA+INlShC3n1LYEMIyd6/GtrfjdKf1bXm6bP6w65A3Qo6WeIUN23fCA==
X-Received: by 2002:a17:90b:314c:b0:315:9624:37db with SMTP id 98e67ed59e1d1-324ef0abdd0mr384183a91.3.1755733988904;
        Wed, 20 Aug 2025 16:53:08 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f16ccf62sm163319a91.0.2025.08.20.16.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 16:53:08 -0700 (PDT)
Message-ID: <526d1aee-d401-4f04-8ddc-122f1fef7905@gmail.com>
Date: Thu, 21 Aug 2025 08:53:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
 <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
 <20250819030239.41a2e97f@foz.lan>
 <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
 <20250819153200.3c2b2ff6@foz.lan>
 <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
 <20250820091530.068c4b62@foz.lan>
 <3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
 <xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Commenting on your observation quoted below.

On Wed, 20 Aug 2025 18:48:10 +0200, Mauro Carvalho Chehab wrote:
[...]

> If you want a more comprehensive answer:
> 
> LaTeX is highly dependent lots of packages, including fonts. The
> reason why you can't reproduce the font issues with Docker
> (I wasn't able to reproduce with Docker here as well) is
> probably due to either packaging differences between the
> two containers, due to different environment technologies
> or even due to the way Docker and LXC handles OS virtualization.
> 

I'm not saying there is no difference between Docker and LXC.

Can you fill in ???? cells in the table below ?
Docker column is my observation of "FROM ubuntu:plucky" podman runs.

 "make SPHINXDIRS=gpu pdfdocs" under Ubuntu Plucky

    --------------- --------- ----------
    SVG --> PDF     Docker    LXC
    --------------- --------- ----------
    imagemagick     FAIL      FAIL
    inkscape        SUCCESS   ????
    imagemagick [*] FAIL      ????
    --------------- --------- ----------

[*] after installing both inkscape and imagemagick, remove inkscape
    with all its dependencies kept.

Do you see any difference between Docker and LXC columns in the table?
I'm all ears.

Regards,
Akira


