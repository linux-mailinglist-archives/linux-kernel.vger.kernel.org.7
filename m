Return-Path: <linux-kernel+bounces-870799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DCCC0BB82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E734E4B38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C462C3769;
	Mon, 27 Oct 2025 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOFPk/sl"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AC2040B6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533639; cv=none; b=SEIrBrnqJELbkrRq051mmkKgltQBkzvejDNS4OnEr2l1tEiiw+4shvgfwIKcJwkqGsRn5kmLTlVi0061KImtaaLYHJC7EpiIntzn5gzR2SbBUjgszCThdDoxejLFSdnOxM0evnN6NbCogAVR6sPsL+Zo2Y8R3B/FeIdGA5Kvkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533639; c=relaxed/simple;
	bh=9ToB783q04/ZLjbD/gt5wlM14tABvZc8zQTEnpTtNAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6bIOyQ+cWgEKBXrNpGaZHYtEyB8smO59iqEy9JrnE2L3sFfHGykHrnzKUEcP7AvwwiX8hLJDvGrrxKtGE2IvG9YPkb5xQ6mhEzFSsZx6NlO1Xz+O6nh0KajC9NZUMORlRebqOyKqIIz1EGdtyNqXOXdPzTFiUGd+BTI8DvnXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOFPk/sl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7833765433cso5183482b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761533637; x=1762138437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVlahTxS7jRPwvwryBn2WGTgohPafv3ZR8htDrtjHFs=;
        b=QOFPk/slUi/x+4+/KhrtjT2MbZHeg+aAklo7Mt3oDZF1D2N15a6L5F3ie2XdjjbKyb
         CtTk7bKIkLDKxHLgNYMyaGZsXnVKpMGtAq6DwQKN7vf7N7yjuIEYVUwg0rjxizPTurZP
         VsdSbth5LPVc399fitGEXQlVbPN4i3jN6pkq+jsccVRuGqDT3xWQvQfG2Ei6j/I2HIBX
         uLHWisV51wA1MNlzTlhfbkMBj/yk41qIzMPGSfqodxmlaxrMGEhSaLyvQMUmV5YH8cVS
         uhdD6rSjJ0rwGvno6Pefg1lTkOSUPkudLWzHw6Jb4oS/knwp3u2iwaZAuq4u+IXcRc4B
         1eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761533637; x=1762138437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVlahTxS7jRPwvwryBn2WGTgohPafv3ZR8htDrtjHFs=;
        b=E7J9yn3klVJxSkRrCxx2lh5pDgVJtwQFfncV9YV7uVVbuT9XxFbsMJJudBJoF8q7ce
         iAFTzA9WMvm8/r25a/+/U0zqLw+7n6MunrgUuYynhE3I1j3Hmlv6P3GZ3ely2kbpNF0j
         YZrAHm0ptVXlfZJtOcvonsJzjEGQtAzqzA/5J4PkIPKvn0ya1QNpOcJR2F0kbzXvXttt
         7fX2SAGiGCReegMCsPUm2WEPkLPoTmQNlIa2FYDs1EV38FB3iZVpw1XOJI7b5FE/69i+
         9uf30wBZA5qTX/DeBfzbYghtF6RA25YzkvFQa3jn4Q/zjGcXQ09KzQRLhuHiPayMjYSw
         UIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd9dwp7NapWOx9oU8fmuUJeTM9JKDAIvp65mx6oG/NpN8EOvJQqfkjONmPWpLAjznOXinM39CfR5AhWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrVCgbhrOYBtD0q2zfR1jHY5lNSfnoO2V5SPk+wGSYB+RvGuY
	9lvrQ0z/5UNGpjdXKqYAK6mjfBAjhVP3uy2OAajyG/ycMdCpUsAOwtrU
X-Gm-Gg: ASbGncuL98wWSF2/+O5Uy7av3nwjOTZbPDA6wJe9AZwopWBv03Ybq0nQiD125tO/4OP
	12jhBUAK0z2x6YwwTn/f1X6Xu+nqt5LUsYfNNUV9IWYglzEJoLM4uxtnI8vvJvXdWYSDsxhMuaQ
	9qFFG/wBEOeWjJbrSg3JnmxapxAmbqxsQp6cm0aiXq9T231KAeb5OcZwtZT7rbLlZYz5tU4P++D
	AM2AT6hb266AVVKWOST8GoAAUtYXScVeqx0onhwWIcq6voBI/NmMmCRyFjJDvWalUrrryqt6JUS
	MxDZMST6wzDqj5SS1BaXOWpe7XXMVgphB0oTK5ZtJAZ/YADjXjjTa7PgVqx8hbfxj0lEwvmTpAY
	u34k0eZfxk6sTTWRe4drtsru2DdoyoWRmlCKXgXQ2MbmytebvNTRXUqIDLh3xA2wMZJ/T0VjGNY
	rd4kL1frDmdNKJ1cIiIcFD92RrGHsvTH+Ue4sJO0xOAX+nzQ==
X-Google-Smtp-Source: AGHT+IHkbhlxjiyHB6Qfk8vz4b8fB+Snb1xTbuTgkveEGfECpKJAS/t70w4tpgOAyldU8hd5twy89w==
X-Received: by 2002:a17:902:cf4b:b0:27e:ed0d:f4ef with SMTP id d9443c01a7336-290cb27eec7mr452422025ad.41.1761533637186;
        Sun, 26 Oct 2025 19:53:57 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm65101965ad.85.2025.10.26.19.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 19:53:56 -0700 (PDT)
Message-ID: <67d1cfd2-a3e3-4a3f-89f5-38e822321578@gmail.com>
Date: Mon, 27 Oct 2025 11:53:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Subject: [PATCH] docs: ja_JP: Move submitting-patches to
 process/ and add to build
To: Akiyoshi Kurita <weibu@redadmin.org>, corbet@lwn.net
Cc: shibata@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20251024235437.801625-1-weibu@redadmin.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20251024235437.801625-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kurita-san,

Thank for your continued work on this!

On Sat, 25 Oct 2025 08:54:37 +0900, Akiyoshi Kurita wrote:
> As requested by Jonathan, move the Japanese translation of
> 'SubmittingPatches' to its proper location under 'process/' and
> convert it to reStructuredText.

In https://lore.kernel.org/87jz0xbk6f.fsf@trenco.lwn.net/, Jon said:

>> That said ... this is not an RST file, and won't be pulled into the docs
>> build.  I would *love* to see a patch that moves this file into its
>> proper location under .../process/ and brings it into the build.

This patch does the *minimal* thing, namely the rename of the file,
with minor changes near the top of the doc.

Yes, the resulting .rst doesn't cause any *new* warnings from Sphinx,
but looking at the resulting HTML (or PDF), I don't think the rendered
page looks nice.

I'm wondering if this is what Jon would love to see. (Well, Jon doesn't
read Japanese and would not mind.)

Of course, I understand you are going to do both translation and reST markup
updates as follow-up changes.  But I'd rather refrain from exposing
work-in-progress doc in the translations docs.

Please read on in-line comments below:

> 
> This patch also wires the new file into the Japanese documentation's
> toctree, allowing it to be included in the Sphinx build.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/translations/ja_JP/index.rst    |  1 +
>  .../submitting-patches.rst}                   | 61 ++++++++++---------
>  2 files changed, 32 insertions(+), 30 deletions(-)
>  rename Documentation/translations/ja_JP/{SubmittingPatches => process/submitting-patches.rst} (96%)
> 
> diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/translations/ja_JP/index.rst
> index 4159b417bfdd..8e01619d4170 100644
> --- a/Documentation/translations/ja_JP/index.rst
> +++ b/Documentation/translations/ja_JP/index.rst
> @@ -11,6 +11,7 @@
>  .. toctree::
>     :maxdepth: 1
>  
> +   process/submitting-patches

This should come below process/howto. Still, as I said above, I think this
addition is premature.  One option would be to put a fat warning at the top
of the doc saying "This section is work-in-progress!!", or so.

>     disclaimer-ja_JP
>     process/howto
>     process/submit-checklist
> diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/process/submitting-patches.rst
> similarity index 96%
> rename from Documentation/translations/ja_JP/SubmittingPatches
> rename to Documentation/translations/ja_JP/process/submitting-patches.rst
> index b950347b5993..4bfa84cc705d 100644
> --- a/Documentation/translations/ja_JP/SubmittingPatches
> +++ b/Documentation/translations/ja_JP/process/submitting-patches.rst
> @@ -1,33 +1,34 @@
> -NOTE:
> -This is a version of Documentation/process/submitting-patches.rst into Japanese.
> -This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
> -and the JF Project team <http://www.linux.or.jp/JF/>.
> -If you find any difference between this document and the original file
> -or a problem with the translation,
> -please contact the maintainer of this file or JF project.
> -
> -Please also note that the purpose of this file is to be easier to read
> -for non English (read: Japanese) speakers and is not intended as a
> -fork. So if you have any comments or updates of this file, please try
> -to update the original English file first.
> -
> -Last Updated: 2011/06/09
> -
> -==================================
> -これは、
> -linux-2.6.39/Documentation/process/submitting-patches.rst の和訳
> -です。
> -翻訳団体： JF プロジェクト < http://www.linux.or.jp/JF/ >
> -翻訳日： 2011/06/09
> -翻訳者： Keiichi Kii <k-keiichi at bx dot jp dot nec dot com>
> -校正者： Masanari Kobayashi さん <zap03216 at nifty dot ne dot jp>
> -         Matsukura さん <nbh--mats at nifty dot com>
> -         Takeshi Hamasaki さん <hmatrjp at users dot sourceforge dot jp>
> -==================================
> -
> -        Linux カーネルに変更を加えるための Howto
> -        又は
> -        かの Linus Torvalds の取り扱い説明書
> +..
> +   NOTE:
> +     This is a version of Documentation/process/submitting-patches.rst into Japanese.
> +     This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
> +     and the JF Project team <http://www.linux.or.jp/JF/>.
> +     If you find any difference between this document and the original file
> +     or a problem with the translation,
> +     please contact the maintainer of this file or JF project.
> +
> +     Please also note that the purpose of this file is to be easier to read
> +     for non English (read: Japanese) speakers and is not intended as a
> +     fork. So if you have any comments or updates of this file, please try
> +     to update the original English file first.
> +
> +     Last Updated: 2011/06/09
> +
> +     ==================================
> +     これは、
> +     linux-2.6.39/Documentation/process/submitting-patches.rst の和訳
> +     です。
> +     翻訳団体： JF プロジェクト < http://www.linux.or.jp/JF/ >
> +     翻訳日： 2011/06/09
> +     翻訳者： Keiichi Kii <k-keiichi at bx dot jp dot nec dot com>
> +     校正者： Masanari Kobayashi さん <zap03216 at nifty dot ne dot jp>
> +           Matsukura さん <nbh--mats at nifty dot com>
> +           Takeshi Hamasaki さん <hmatrjp at users dot sourceforge dot jp>
> +     ==================================

This historic contribution record can be removed.  The same happened in
howto.rst when Shibata-san did the conversion in commit f012733894d3
("Documentation: Add HOWTO Japanese translation into rst based build
system").

Instead, please put a translation note referencing the disclaimer
under the document title as is done in (ja_JP's) howto.rst and
submit-checklist.rst.

> +
> +========================================
> +Linux カーネルに変更を加えるための Howto
> +========================================

Title of the original now reads:

  Submitting patches: the essential guide to getting your code into the kernel

Back in 2005, it read:

  How to Get Your Change Into the Linux Kernel
          or
  Care And Operation Of Your Linus Torvalds

And the Japanese translation has never had the title updated ...

Probably you can align the title with the current one.

As before, if you are not sure of the way to do, please ask me
before submitting a next version.

        Thanks, Akira

>  
>  Linux カーネルに変更を加えたいと思っている個人又は会社にとって、パッ
>  チの投稿に関連した仕組みに慣れていなければ、その過程は時々みなさんを



