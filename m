Return-Path: <linux-kernel+bounces-802557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CADBB453C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276DE7B59A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F428B501;
	Fri,  5 Sep 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlrdmfIv"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357F1F95C;
	Fri,  5 Sep 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065726; cv=none; b=fmUU2T2eScclkM2JBWKUoTcO27isikehCv7mvpHq1XUAYDm81j1ytS5S5YqVgzHds6DdFAWFkDwZIUHcWSUwt4UeOmeYZHkbi7FKKzxqCHWDqe9v3iJ2ayB2rJLfDGftJOQSA0oMqLGTf02Z4L6jd5zkCj7s0ASHJzaJi7xhxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065726; c=relaxed/simple;
	bh=J6ciJK5OYseCx33oRWPiAdiT2KynTrlqrDJwgJ6C0Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIe0gcMoGq/VUDm7064gSv1fslwyUmjh1oBxRk0WiH3FxCKx7G4RrtKQ0ro9mb2QNyK8w8ewa/S72GqomJMspWXzbqNH0EeSQxxaaz+FCCPzaRB6K6QCNPB3YD2YNxsl4YSURMkVyg7o4zpqSxNCKwwRTWwAD0OU5iStNgZ/gJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlrdmfIv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso1808459b3a.2;
        Fri, 05 Sep 2025 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757065724; x=1757670524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VJo/YxZFHdX+2Y/e8DgutYHf/cZ8cVwYUuMWvfuEzw=;
        b=KlrdmfIvtRC0ayFmBgyOC3u7wpOHuRCRyyThpV4ntNM4enhcJvKZP/CIGcGSquDgO1
         4sK2D+NzbFaLU5i73gXbFHLkL60gcfZXAYcwgV95bBoCZj9DQfd+wwlbZkeTCIKIf88x
         7kCOKwlEU4fQlsZjwAk9UmQiPOUAGTNXfBcsTjHPAoWnggDNsBCNtuPkJBpZAkCXM8GO
         8iHQzTPiSVUdDriuF9pXkyweOAmPlNAFB4m0Rzf8Kl34C0l/aLhosId0Ek44ZXV+LzCF
         DbWZ6oG8+JchyjXtNWdYURJ6YSxJeEgOQmm7ASWEJkPZSTbFDASLP5iscfjh3Wm0Luut
         x15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065724; x=1757670524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VJo/YxZFHdX+2Y/e8DgutYHf/cZ8cVwYUuMWvfuEzw=;
        b=Xv2ZhTR46rPmtgeCjUihbiUwpnL1entzJaDmTxSOtjUC4RCkXEpRnmk1UWJ0H67Bez
         IufIP4NAXRJACSchWYmCsX/vkHZQWuNB8QPj2BKKLBiej39HD3rv18UXjY29mhXsiNYk
         A+GXMCTC+WLj+AjCypsJKtieTC6MohWL+O/yCG5fBIAZ/DF4Fro8a7cnHDNS7nMGOLv5
         p3SUcaPxOEskcQNO8/JA9CbBIWJnMQQ4eH9nx/3yLmN53qzWOu2vNc1hkG2Qk1vOSPAD
         2hsc+P3GxQ7aoGIFnfeHlop8XnJLYzVyoiD604c5O1BibEeWvaZUelLe0z0VC0PNhXLE
         mcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXFIzr2Kz1h2JZSHEmPu1sDF41LBS0aBii9401SGNHJxD62DBZvStb4tdzRRxnZtaaonWUgqeCuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxfks1Jp9PpF4zsgKOJapUXfd1UMWDBd/Ey/ILkIITrOva4wO
	S+vciIc17KRx8iVW7r7uip9uPcld+Rts9M0qGWimcGoqU7s+HW3HtBJm
X-Gm-Gg: ASbGncsjsiInZeOZhdXZ6ArWqFx2nIaftg9YfMxGKtZtl1wcSjosYamxZW5lT9JczOO
	/Afji2qpbNNRj5ECSMIz92XNcYSgXcBQHo09SD/ZbllOtYaNfL/tr+qvujSEfyLY+O/21BTXpm9
	vps5VJ3tukm1mheOf5LKKmVl4k9DXcxWLtuZyRnFk1EbH5f6eqCHjMrGKYbo/kZGjmKmeftCJgo
	cp5ZriNNeoMUMZVvUMWV8FSoAwuxraEb3CN4e46DB85++dP4QyqVvBb0H3tXi2vQvo1t3axYRDn
	bgreicf9WKBasv1DOAawq0a3IaBzMVljgpG3NwtP6mjmQwfq47bXcS8k35FTzZE2PlD9rrNNz0b
	SlfmrNvhPH3Sd3ebQgB2mON1A1faEtYA+pVcy734qBn983gWUFy/HRy55kLDvtvSnmEXh
X-Google-Smtp-Source: AGHT+IGCLSjxEXR/wi2vz5IPAOhDThSY2NgzoLNBrcBpcqFYnWzkme349pBGV3dg9DFXNIknHI6eng==
X-Received: by 2002:a17:902:f549:b0:24b:e55:34b with SMTP id d9443c01a7336-24b0e550987mr206891555ad.31.1757065724142;
        Fri, 05 Sep 2025 02:48:44 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm34957405ad.144.2025.09.05.02.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:48:43 -0700 (PDT)
Message-ID: <cbcc3317-958c-450d-afab-e9a29b1d5add@gmail.com>
Date: Fri, 5 Sep 2025 18:48:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ja_JP: add guidance for the Fixes: tag in
 SubmittingPatches
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net,
 Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
References: <20250905032729.2284883-1-weibu@redadmin.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250905032729.2284883-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Akiyoshi,

On Fri,  5 Sep 2025 12:27:29 +0900, Akiyoshi Kurita wrote:
> The Japanese translation of SubmittingPatches was missing the section
> describing the use of the 'Fixes:' tag. This patch adds the missing
> description, aligning the translation with commit 8401aa1f5997
> ("Documentation/SubmittingPatches: describe the Fixes: tag") in the
> English version.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---

This one made my imbox. Nice!

>  .../translations/ja_JP/SubmittingPatches      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
> index 5334db471744..28ad83171252 100644
> --- a/Documentation/translations/ja_JP/SubmittingPatches
> +++ b/Documentation/translations/ja_JP/SubmittingPatches
> @@ -132,6 +132,27 @@ http://savannah.nongnu.org/projects/quilt
>         platform_set_drvdata(), but left the variable "dev" unused,
>         delete it.
>  
> +特定のコミットのバグを修正するパッチの場合（例：``git bisect``で問題を発見した場合）、
> +少なくとも SHA-1 ID の最初の 12 文字と 1 行の要約を記載した「Fixes:」タグを使用してください。
> +タグを複数行に分割しないでください。解析スクリプトを簡素化するため、タグは
> +「75 文字で折り返す」ルールから除外されます。
> +
> +例:
> +
> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> +
> +以下の ``git config`` 設定を使用すると、``git log`` や ``git show`` コマンドで
> +上記形式を出力する際にプリティフォーマットを追加できます::
> +
> +        [core]
> +                abbrev = 12
> +        [pretty]
> +                fixes = Fixes: %h (\"%s\")
> +
> +呼び出し例::
> +
> +        $ git log -1 --pretty=fixes 54a4f0239f2e
> +        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
>  
>  3) パッチの分割
>  

So, this doesn't cover the other hunks in commit 8401aa1f5997.
Instead, it includes the change made later in commit 5b5bbb8cc51be
("docs: process: Add an example for creating a fixes tag").

Your interpretation of Jon's desire might be different from that of
mine, but I think Jon suggested translating up-to-date
submitting-patches.rst as a whole.

Of course that would be great, but I'm not sure it is a reasonable ask
here.

I think covering both commits 8401aa1f5997 and 5b5bbb8cc51be might be
a reasonable middle ground here.

What do you think?

It's 100% up to you how far you want to do.

Thanks, Akira


