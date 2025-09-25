Return-Path: <linux-kernel+bounces-832362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B311B9F13F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B5A4A01E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3429BDB9;
	Thu, 25 Sep 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGguBJVn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3626F2B6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801833; cv=none; b=Iga1XuSZIzUVAd9otMe/Nmj4i/NVLXVsB64+yna9ZAYKOVTjuVD5WGFVNlyp+XcqesH4DYPqS68B6NNP06uhYIGqym7MrM9Y6aoe7t+lGB60muI8NwkJ2ZxemAgg28ON6xPZQXVLP1kocktAxCMF95lhl7oqAtMkabagemJvnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801833; c=relaxed/simple;
	bh=EkYKBhzMOCQkcO42MvG75nly0zyPDzLyZ19vcPcM9Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlZykYLFXB/OoE+12H1sfe/LCGPi2tw66+LHNY0cXBWdcBtvA0Uh/MfD5nOsRMraO7rxK7MUa2blc+ep3S56rKwMf6J7OGoIGtAfJn46tuglZ7k3dAf8yNT+8x45TndFeZk5BS/+onI/gj4WhWlDIzxcDmpYVXvrEtpwW9c80yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGguBJVn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54a74f9150so799069a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758801830; x=1759406630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7XeYux20aObWFLCbIM7BIfKuI/DjKlpqPLcpFKd7vg=;
        b=YGguBJVniGaC9fa7A5Nvv1rm4hy2kZclV9Q1Uki7+9DU1bEdEJssvMHnltQnhfQr3q
         NgWTgWVBSDByAcVVzjPQx4lCocyGvUX/1vtdDfZ4oy+KNFfnUIfsr1aRv9xz733Mg/IV
         r2PDp94xk5/BphUv0XYCq38Be1i4jlN5bGU4eQZQcZOEp6XgnOEIJgnbY439NAYosUZA
         MyKCW5Zv5CHtkXPMvzcH3CJ2Odw32+F6Vs//xXcgolANxabK7lqWdzlrhkCIQ4IlnX79
         z+/8eCnH4A+hFQdss/iCtaNU4gEITSs2j59Rto0gR7VLPwiytVR/034qkZMfK81JfPpH
         LdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801830; x=1759406630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7XeYux20aObWFLCbIM7BIfKuI/DjKlpqPLcpFKd7vg=;
        b=NSNfhhpXpYERnjTgDEfDbDnLzgxgnaPzuoUXyY/W0VHSu7IYB+H4KuC50cZ1TgGHay
         0sd9Q51mZOCFtpzpWnVTelXkQTyogpCErmrKUEr90lYq/UGz4+UCe1NtGDqXOLncc5BK
         xyZaywtoSnyU3NclKaaR/ywllXWI3f7GsQ54mNokZWFe8t8VjYbTwDax8Etvi86AP3sE
         w1epgRkowa3ji07mo5QbF79HeeEQkVgDdYRwprQXwn0L2UxvRd+G+DV4G+q9axbeQ7+3
         yFM/Yy1rG3awv3PVV9aBLSTtYLzAsixpYU+EebRMExVig6leMNX5/Kz43oaQ39Dk0/6Q
         c+xA==
X-Gm-Message-State: AOJu0YyXqY9cre3Yc7R3tmlBXMOC2kII5qS5ZvUolgWJGe8JotzYmQcH
	zK7k0KYQdg/JX4K7/gPFofGQdMn+UGkR7oFK4UTopc60lk4ILPXX6y7f
X-Gm-Gg: ASbGncv+SnQClbgLid8LTT+dcTCBsC55ug8teeLizMt9Wo3r/wufF6Cmzog+cnkpgT8
	jKXPddNW9/fyij1DmDCwnk6XqScg4G+d/czxEPDv+EeFaS05JlnjOm035arDfOtJWrUCzV5kb1V
	LPeQxzJm+5RcJVl2jTHjkj38nIv7vVOBfwOsJbeaJJbkL9vD9m3T/HYFUx7grXKXamHtpbdWl08
	7Gq737wibyadzaBXqWNmn0UxrW3Tndmw6RbvP2djpa8otaGc5jo4ufcd8JGzjmDamJHeokzA64g
	3mDZpfeRqYCOUSAat6fgea/5owiMaAIGwVd/hHUGzlnc7szX8NehDhPtd5QM27M5DC8OAV84f1c
	wirIekQN72+GkVgkxJ33LhJwQN1Uq0ocDXEEgw1dvlFSN6KrOpIlzotMZYVoiMLCCGeTkDYgYt3
	kuXdg=
X-Google-Smtp-Source: AGHT+IElikP6aV/kIBSSjNAUQu/Gm4A7xzU/BO3mbefIFS6StQ05Lb5WW4iUOWX51ONBT+Q8+oWLzA==
X-Received: by 2002:a17:902:ef44:b0:246:a543:199 with SMTP id d9443c01a7336-27ed596f868mr33427515ad.54.1758801829331;
        Thu, 25 Sep 2025 05:03:49 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6712214sm23759845ad.41.2025.09.25.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:03:48 -0700 (PDT)
Message-ID: <cf30e7f5-4241-48ee-bfba-107144e4e9a9@gmail.com>
Date: Thu, 25 Sep 2025 21:03:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] docs: ja_JP: SubmittingPatches: describe the 'Fixes:'
 tag
To: Akiyoshi Kurita <weibu@redadmin.org>, linux-doc@vger.kernel.org,
 corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
 Tsugikazu Shibata <shibata@linuxfoundation.org>
References: <20250909022502.119560-1-weibu@redadmin.org>
 <20250924192426.2743495-1-weibu@redadmin.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250924192426.2743495-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[+CC: Shibata-san]

On 9/25/25 04:24, Akiyoshi Kurita wrote:
> Sync the ja_JP translation with the following upstream commits:
> 
> commit 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: tag")
> commit 19c3fe285cba ("docs: Explicitly state that the 'Fixes:' tag shouldn't split lines")
> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
> commit 6356f18f09dc ("Align git commit ID abbreviation guidelines and checks")
> 
> The mix of plain text and reST markup for ``git bisect`` is intentional to
> align with the eventual reST conversion.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
> v5:
>  - whole rewrite

This looks good to me.  Thank you!

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

You are lucky in that those four changes related to the Fixes: tag are
pretty much localized in the English version, across the conversion to
reST.  With regards to "Fixes:", ja_JP/SubmittingPatches should be
up-to-date by this change. 

Regards,
Akira

> ---
>  .../translations/ja_JP/SubmittingPatches      | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
> index 5334db471744..b950347b5993 100644
> --- a/Documentation/translations/ja_JP/SubmittingPatches
> +++ b/Documentation/translations/ja_JP/SubmittingPatches
> @@ -132,6 +132,25 @@ http://savannah.nongnu.org/projects/quilt
>         platform_set_drvdata(), but left the variable "dev" unused,
>         delete it.
>  
> +特定のコミットで導入された不具合を修正する場合（例えば ``git bisect`` で原因となった
> +コミットを特定したときなど）は、コミットの SHA-1 の先頭12文字と1行の要約を添えた
> +「Fixes:」タグを付けてください。この行は75文字を超えても構いませんが、途中で
> +改行せず、必ず1行で記述してください。
> +例:
> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> +
> +以下の git の設定を使うと、git log や git show で上記形式を出力するための
> +専用の出力形式を追加できます::
> +
> +        [core]
> +                abbrev = 12
> +        [pretty]
> +                fixes = Fixes: %h (\"%s\")
> +
> +使用例::
> +
> +        $ git log -1 --pretty=fixes 54a4f0239f2e
> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
>  
>  3) パッチの分割
>  
> @@ -409,7 +428,7 @@ Acked-by: が必ずしもパッチ全体の承認を示しているわけでは
>  このタグはパッチに関心があると思われる人達がそのパッチの議論に含まれていたこと
>  を明文化します。
>  
> -14) Reported-by:, Tested-by:, Reviewed-by: および Suggested-by: の利用
> +14) Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: および Fixes: の利用
>  
>  他の誰かによって報告された問題を修正するパッチであれば、問題報告者という寄与を
>  クレジットするために、Reported-by: タグを追加することを検討してください。
> @@ -465,6 +484,13 @@ Suggested-by: タグは、パッチのアイデアがその人からの提案に
>  クレジットしていけば、望むらくはその人たちが将来別の機会に再度力を貸す気に
>  なってくれるかもしれません。
>  
> +Fixes: タグは、そのパッチが以前のコミットにあった問題を修正することを示します。
> +これは、バグがどこで発生したかを特定しやすくし、バグ修正のレビューに役立ちます。
> +また、このタグはstableカーネルチームが、あなたの修正をどのstableカーネル
> +バージョンに適用すべきか判断する手助けにもなります。パッチによって修正された
> +バグを示すには、この方法が推奨されます。前述の、「2) パッチに対する説明」の
> +セクションを参照してください。
> +
>  15) 標準的なパッチのフォーマット
>  
>  標準的なパッチのサブジェクトは以下のとおりです。

