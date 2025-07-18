Return-Path: <linux-kernel+bounces-736115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E4B09901
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A0C16C85A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B302A1BF;
	Fri, 18 Jul 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOzev+uc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923B191;
	Fri, 18 Jul 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752799861; cv=none; b=aWgE07+Kpcj82A60qTE2p6NNlw28Cv5S/aXSmOKulGNFGcHm+5T1LPdOQwuJyzWlj2QP5RaVNC7uFeg0LAqqU0yi13+Szx37emAa76kLfHMeKmAwM8NSzuMt7RNe+lv2pCafTDK1vnLo8jAvjHKPJwZ9n5za16Ko/wfXnlLGt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752799861; c=relaxed/simple;
	bh=qJWrX9/rodnVspXi0DgcHE9HuUG1qj7gYOfqZf31Iqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxJEsJaEUcGjGvbBv4vKKfTQloeIL9oiesjf8IAlbbYz1X1mnePtdLScdyHU4tF2QBm1Q+WTyErdOdkMRO2q1vq2NpgqdBgJtPuc8OaGnPAPApVDAqirI9MOz7f766bC5D/ClCORad9W/ygU2HSOsRiAZUGN1cnHWAlGCUlNrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOzev+uc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235ef62066eso20192655ad.3;
        Thu, 17 Jul 2025 17:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752799859; x=1753404659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSJaJwZPnnm5CrnRDp4Vx968VO9FwmenbfNb5gsqu8I=;
        b=NOzev+ucJNGHaay6LodvRi2O/CZtE/hyRO2ZrjXWlH27giMN4X7lpemNEEI0kIEBjG
         xNDoh3tehKGgbPmbYvYJ6JrGLE3eVufpiYlWr0GdMtsLrwly/HlnoXHZg8TJykYCQp2h
         Y/lq1yXjOdKTflb3tlQ0vcald36fyKqguPcjn3NN6Iksu6z+WxMMm0/Iu1phsadag3Co
         3k7eFEv52zGP7V1wI9abLw1nHaQSPqZXdr8FGdO4OFHNqr2jSgYEzWvrTsZ8xuSTEVUZ
         AWzocqPQ3WYxtKuILC9s0cWTYJefOg1LYDtRE+DHQn8S9FfsGhL7INGaa4gdeDAno5Zt
         2lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752799859; x=1753404659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSJaJwZPnnm5CrnRDp4Vx968VO9FwmenbfNb5gsqu8I=;
        b=nZ6FMX0PMzA2E6LG6FBSyYtZiKqhVvYFLaHHGLMtBKrXdi6qdfFFCCjB5QEiyzle42
         BFEapQWhZjyyX2JJlIVnqq3V8azHfeEIfRJpCj83zC2dMc6RaHfXK1PVeALdQ6MdQXCE
         Qoc1aSXwCI5TxKj3+V5u89AdDq76uuxKlrU5NWzjVOXsFhG3HkWnUYKbw6f4ewGKJqvi
         2c81VKalUmW0/U/m+g9n48pMD4/Jq1mKTLY9nxQ8jAJkNG6seANr5rEltnS0bWieh3pK
         27rybGCG/z01PiOUnNuROaCJ/uwF0w2n0tL0STDMIN4GtpzeVkOLiXsLc1CAeOW2mv5Q
         7MJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj/EJSSDa+hEK9XiERcmNpCUDls459QmruFvPyp6ZWQgkvrOgBmYh0QHC/36F2IomkjDcnEoxjttY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCupziBzKCT0jnu/PsG9gSm5fFE2Va7QuFgXsYqic8ZL3odIIt
	t1RMW04DvzmB4Wmd8BRWj0goYpmhgzyBScYm0WF+Z7KhjO0wT616Cna+j4j00w==
X-Gm-Gg: ASbGncvEQMKPAtaWEJOYXt0LgyASpfJJfUUUE1Qo7//OvvEbKvK5oSoBIiWT2YwFd6o
	Dj8ffz/BDhSmdFZneH/L+++9DYdprWeid2lqK7kxbs6nQgvcNXSquecwd0qHOMnf/82S/SWWx6Y
	xOe1IS8wiUynua16iDMmMLj8iub0Bni7Vj6ulcDzALvqnrEKl7n3aeYIeY9VQrVpDC9F31CZH1I
	vI2Ywj3k3dqn+fnQm+GwcxuSqbpBwjIiHrBrUfSLRndnu6MsIxD+YaLVY0akQe3fua5HnexZY8T
	N6p1pdJVHgLpXOy7PVvKKxCOk2tqbjq6BgaNGWC/jXdu6f7GRDcYah+u+qDAJQ6dH7f//776fny
	5Wt0w/U52rgPzNPhcgC1pnpFI/2vvtzxUAAD2CTDStDNKl+BgZVrPIK1HxINOd3fBDByS
X-Google-Smtp-Source: AGHT+IETuB0GqrXwI+j+HIjCbsJciPgYnbh7q2ELxTQu3EPo46YLWqenC90Z1t4eZJiROm0zJReo/A==
X-Received: by 2002:a17:902:e5c6:b0:210:f706:dc4b with SMTP id d9443c01a7336-23e302a2848mr61236825ad.13.1752799859507;
        Thu, 17 Jul 2025 17:50:59 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e4792sm2565005ad.22.2025.07.17.17.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 17:50:59 -0700 (PDT)
Message-ID: <da247b68-12aa-43ed-83f4-65503bf90c74@gmail.com>
Date: Fri, 18 Jul 2025 09:50:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sphinx: kernel_abi: fix performance regression with
 O=<dir>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <e25673d87357457bc54ee863e97ff8f75956580d.1752752211.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <e25673d87357457bc54ee863e97ff8f75956580d.1752752211.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:37:19 +0200, Mauro Carvalho Chehab wrote:
> The logic there which adds a dependency note to Sphinx cache
> is not taking into account that the build dir may not be
> the source dir. This causes a performance regression:
> 
> $ time make O=/tmp/foo SPHINXDIRS=admin-guide htmldocs
> 
> 	[OUTDATED]
> 	Added: set()
> 	Changed: {'abi-obsolete', 'abi-removed', 'abi-stable-files', 'abi-obsolete-files', 'abi-stable', 'abi', 'abi-removed-files', 'abi-testing-files', 'abi-testing', 'gpio/index', 'gpio/obsolete'}
> 	Removed: set()
> 	All docs count: 385
> 	Found docs count: 385
> 
> 	real    0m11,324s
> 	user    0m15,783s
> 	sys     0m1,164s
> 
> To get the root cause of the problem (ABI files reported as changed),
> I used this changeset:
> 
> 	diff --git a/Documentation/conf.py b/Documentation/conf.py
> 	index e8766e689c1b..ab486623bd8b 100644
> 	--- a/Documentation/conf.py
> 	+++ b/Documentation/conf.py
> 	@@ -571,3 +571,16 @@ def setup(app):
> 	     """Patterns need to be updated at init time on older Sphinx versions"""
> 
> 	     app.connect('config-inited', update_patterns)
> 	+    app.connect('env-get-outdated', on_outdated)
> 	+
> 	+def on_outdated(app, env, added, changed, removed):
> 	+    """Track cache outdated due to added/changed/removed files"""
> 	+    print("\n[OUTDATED]")
> 	+    print(f"Added: {added}")
> 	+    print(f"Changed: {changed}")
> 	+    print(f"Removed: {removed}")
> 	+    print(f"All docs count: {len(env.all_docs)}")
> 	+    print(f"Found docs count: {len(env.found_docs)}")
> 	+
> 	+    # Just return what we have
> 	+    return added | changed | removed
> 
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Closes: https://lore.kernel.org/linux-doc/c174f7c5-ec21-4eae-b1c3-f643cca90d9d@gmail.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Tested-by: Akira Yokosawa <akiyks@gmail.com>

Thanks!

> ---
> v2: updated description. No changes at the diff itself
> 
[...]



