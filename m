Return-Path: <linux-kernel+bounces-763312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B8B2130E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C573E2286
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3D42C21E7;
	Mon, 11 Aug 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="V2bEdxkN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBC212B05
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933046; cv=none; b=sY3VdryW4/LULww5Dr7BQ0HHRkkx6cmjUO7KE65p+HwmhnQC90E+YRNvgwcHxuRXgb89R7VzcdlusOrwmB4/eQ9qyst58Lji8jHOOL+1aFZSzZy/BUE+FDB97hSrAjEpOFthmnDmtEwav6sjVx0wNqoakfI8w1At+QcA72xf1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933046; c=relaxed/simple;
	bh=/A+ooc2EbVpb2JwsR0YHFg7w6kTt/ZqxoEkItRvXPzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FK8FGAod34cqOR+mgxoxwrENl+iapo2hIBhO4SyTUG7lvO3pC1FaQlrgPNcLsVvAmHBdQr6X/9VnSq8+GHjmTPdX8CZISCNbBvr7aX9pWYIzQ2BsgnsaVe97S1zneLwKxYf+R3kS5CeTHWz9hbDNJUTXpXhzu4Y6Ip2luM7l0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=V2bEdxkN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FF4240AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754933043; bh=tOqoxC3kPM+8PGaZoXIkkPafaFMsAV8yEbKKwohhu6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V2bEdxkNTn/nsYHRXXBY69vaEf4Npp64Aje/p1Az3y6nOmqpVRnY70UEcNdxrrtzG
	 t0LfkAOwO95HmrttJlVzc+p6v8gyqmi+HdBtCnB+XGL0FDzcFbBB7j5T1mDKeTiD2r
	 3VfjrXsilRQgI5q2CrhC4ZIYnhGDncct0IH9Ynr/t6NWywK8O58SuMI3NP/maU2PVC
	 nLmpdFblTtFENVyYZJR+Oo73+nh2LC89Y/MqD/PCcPFWjNnUHqMMAciuVKpfC4Qr4n
	 XN49cdv3q/Uoin5HDYsk+4VzuWoZiOH9eKYzSMLrC40NBUbSCty48VGrenIsIwcFNf
	 pxX/JnG47j3tQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6FF4240AD9;
	Mon, 11 Aug 2025 17:24:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang LIU <tttturtleruss@gmail.com>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang LIU
 <tttturtleruss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/checktransupdate.py: fix missing f prefix in
 f-string
In-Reply-To: <20250811170704.99420-1-tttturtleruss@gmail.com>
References: <20250811170704.99420-1-tttturtleruss@gmail.com>
Date: Mon, 11 Aug 2025 11:24:02 -0600
Message-ID: <87qzxhdb65.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang LIU <tttturtleruss@gmail.com> writes:

> add a f prefix for f-string
>
> Fixes: 63e96ce050e5 ("scripts: fix all issues reported by pylint")
> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
> ---
>  scripts/checktransupdate.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
> index e39529e46c3d..b57fb9139f5f 100755
> --- a/scripts/checktransupdate.py
> +++ b/scripts/checktransupdate.py
> @@ -131,7 +131,7 @@ def check_per_file(file_path):
>      opath = get_origin_path(file_path)
>  
>      if not os.path.isfile(opath):
> -        logging.error("Cannot find the origin path for {file_path}")
> +        logging.error(f"Cannot find the origin path for {file_path}")
>          return

Ouch, good catch; I've applied this.

Thanks,

jon

