Return-Path: <linux-kernel+bounces-815989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA35B56DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFCE3BC419
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CA1F4CB3;
	Mon, 15 Sep 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwfgijX9"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190A523A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900326; cv=none; b=EVDWj66BtTiKtiSlvIBqywVBLdyXYtpDyTc690ijS/qexBm2nFhXiNsGT0NHZHWqPOboKiClAf8JweDqkNDK1fZaZCdfa0YGDo6tpvwk8rvnHD4jEjBSf17jkBlzcmst1quOc7TaLwfA0cdUqcG1THDUkaZoX0hXbnfLOzG/l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900326; c=relaxed/simple;
	bh=Ca/QCDvXVR7AgonlUSjrZVQLJ/PN+fdGdJKjm9e7zHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWoHdDtXqcuIFyZorvhbIOLDQ6MQEUkV2MWhPle6RZNnTUbJ7DM1sP3hkrLxo0+dO8QlCalYyJ7cGhWnN0pVaW3gDpHy2q1AK2KSVk1ZynZhyJAPixUVfWB8rzePpmRvFKhZK81QiKb2PnwLBxILMnUjASiWvIVGJrgMov8qtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwfgijX9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so2918119b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757900324; x=1758505124; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpbaRkToGs8yflVgnnAwbTXWW3ZX47JRzh85y74Z7nM=;
        b=lwfgijX9J2/xjderEzsVsiOerI32Bh9/obAeW5Ntp4nis70gkCo/XAMWsRiRqv1ahU
         FRO+uTYBDAPhBGPwzCEh8TZ83s/KuIpbdtlYrBTNFeJITYh5CGhHR3HYw6sSaSC07eTe
         QJcRoZPCheyF8uGlAg8/Bn0ijfW+/nA8rsA2tgOELYbkmRDGgqiFl21bAEle3rVqpca+
         J9zS0abqNurEwNFoXTC1vNX7d0f2JkHFKRudQjtn8dqUhBZe4DIknlsUlkaHWKlQXqLo
         TCSdMSnFBBcrniSqNsdbesReJd0ih9QR2EzRJgdRpIjDTvhtA61sgkABEeAzhqSe6mnd
         1LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757900324; x=1758505124;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpbaRkToGs8yflVgnnAwbTXWW3ZX47JRzh85y74Z7nM=;
        b=l/YgZzUlijfewdflB/Rk5+L9d4PtRtcWAqvmqCTkoxIswWcYxP6lgIITMIjry6Buvd
         9qblV7K3Faah00R8npOFpeEDzzUENWm046ufSX89MoFzvBKXA6mgSTv1lM0Mzg35bn+1
         00uoiRLHHLTlvBayeH7w50PZjFNlmURZoYTbLPTYC1J6fctDkW1X+o/Zj27pCYXtW/wE
         IgpoczNrfo9fHNOQTnab5fMQu4LyGf9eMzxHMWc8fORnjgJykMn7Lf8Bi/eO2g6e8Xo9
         ivzoSNXye+sCOH10/mV13hQy+BnEmxf5Z9IbmPKNhDLjNA8Cvn/Yk51fSviUTncbn28U
         M6IA==
X-Gm-Message-State: AOJu0YwO2ZVb08YIzPHW5AU9d82yGImQmH9EyVC1iof43mLEjaAoNGhA
	ff+XWM3ZdXieox+oGgizUW/RkykxewaclRTyFM4w4KeMG8aQJOBwGICPecoWpAc4
X-Gm-Gg: ASbGncsOzChXOpSrdalQMPE8lKfREO1fZZ1iy2AwW2loe4femX4ogMvih+6BLvQyoxU
	VK8vVTC6d6v87UdI3xs0b+DfIUOg8xWp8hcEInjEixwXsLoWaL41MwzJNyOMKuPbZrtteiMXQbm
	2Pi4F39xOC1tsOkXkwsY2wKTYg1X+S9PKQPrdzK6fF0T5m2fRewyrvBa89ygw4UKe7Z/FAf0/dz
	ZeAw9x6fa7p3DrgH8gPLIM8iReA2nOKrpJWJMo2ujDZikGVtBvOtV1w6DXGhmhslxs8BbTfMcTF
	fR61QJPCj3LM0SVmlCIN9gmRhcGeb6aLD9YgzhdliWGIzf2WPVcQWNPYLl+ME8P1BKGOFe/mk9G
	yPflNl0vkkYb6lGg=
X-Google-Smtp-Source: AGHT+IHvc7z/xYkpGEvqk1KW+D6wzVKpUsAsc4YLRJ7qpy7gtMveUMS/P/rYt093bXrfGXXMCKoQKA==
X-Received: by 2002:a05:6a21:3394:b0:24f:b82d:4255 with SMTP id adf61e73a8af0-2602c90cc91mr13158746637.42.1757900323906;
        Sun, 14 Sep 2025 18:38:43 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::aac3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54d2c413e5sm537870a12.40.2025.09.14.18.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:38:43 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ver_linux: Reference coreutils instead of sh-utils.
In-Reply-To: <9ecf7c579454d89c73b8d2c29d13ddb1768079da.1755310602.git.collin.funk1@gmail.com>
References: <9ecf7c579454d89c73b8d2c29d13ddb1768079da.1755310602.git.collin.funk1@gmail.com>
Date: Sun, 14 Sep 2025 18:38:42 -0700
Message-ID: <878qigpk9p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> The Fileutils, Shellutils, and Textutils packages were combined to
> create GNU Coreutils which had its first major release in 2003 [1]. It
> is unlikely that someone is using Shellutils today, and likely that many
> do not remember what the Shellutils package is.
>
> [1] https://www.gnu.org/software/shellutils/
>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  scripts/ver_linux | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/ver_linux b/scripts/ver_linux
> index d6f2362d3792..222e01eb9697 100755
> --- a/scripts/ver_linux
> +++ b/scripts/ver_linux
> @@ -45,7 +45,7 @@ BEGIN {
>  	printversion("Net-tools", version("ifconfig --version"))
>  	printversion("Kbd", version("loadkeys -V"))
>  	printversion("Console-tools", version("loadkeys -V"))
> -	printversion("Sh-utils", version("expr --v"))
> +	printversion("Coreutils", version("expr --v"))
>  	printversion("Udev", version("udevadm --version"))
>  	printversion("Wireless-tools", version("iwconfig --version"))

Hi Jonathan, friendly ping on this tiny patch I sent last month [1].

Thanks,
Collin

[1] https://lore.kernel.org/all/9ecf7c579454d89c73b8d2c29d13ddb1768079da.1755310602.git.collin.funk1@gmail.com/

