Return-Path: <linux-kernel+bounces-736108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC21B098EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640504A3D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E95EEDE;
	Fri, 18 Jul 2025 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzdCYs5P"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DE2E36EF;
	Fri, 18 Jul 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798170; cv=none; b=gnwvdKe/WNY68AZw6+Xda3riwtj3FQocKKYbW+TmQBNh70Ot7KXpCnhWjHwmnFhR9OEors4TkYCRMpjbuDCbMuZmQ2BTn8OsSOX8tFyj/Eyt3cN4Epod2ONs5DEbgWq4P/9mcbTbS3KXlXhiu0WpLAiAUdSa/4Bldcoodwx2wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798170; c=relaxed/simple;
	bh=5D24Yats9OUD5GKgE/Mb0mn8wxBYF4C04/mt+lRxWd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsGAHnKSg7uCv+JNz7DqWcbNJA83Rb/jtGI366CSiJlrb3TdATXQ3aPBkWjCnlYrPFzFnEBppu5ycovc1g6pobr2o7T/0LXYKig2Fp+2B0emkZSTcro+DXgAQLq0YPMmYiTb4Ne0g3HAg9kgD35jflQZLMomY5ERe+ttxnBD8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzdCYs5P; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7115e32802bso10899167b3.1;
        Thu, 17 Jul 2025 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752798167; x=1753402967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okdJZu8d9n72TAdY+I5DSqLNgJe240pc/MV+lj7VvjY=;
        b=FzdCYs5PDmwXbhPw5DGmBEIqGtydNYih0b5lHmH7Zsk41XkZoYdp4/q06eWch/xfvD
         0ZjmdKjM55nqg+2Ltanl76E6/4aASjbDcIK9uObm83RFM5nC9ByROy7aR/Uga8jTAUN2
         Qet4QyqXRrbp28FG18Q+mWBGxok1uSu+tvRHcHjqaluq2+y7QDEj1Cs2yL30JvJeAUEZ
         hn59zJSAIIHBoXveMq02rFxwiCcFji5GMY6NnN7g0gG5RnitlwRw0UY7TY+deFGGKkSo
         x7eZoCH+zJz3G2zGUhAd7Rm9Rt+QyUwAryDzFnMlnt1wZ5+RTDu4sKNBvhbO8DiHxrjt
         gUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752798167; x=1753402967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okdJZu8d9n72TAdY+I5DSqLNgJe240pc/MV+lj7VvjY=;
        b=ujm2rYQiE6Mfsbv3mA7oXqLlGA8r+61K7wZOHBel8JnbNVNoNietAK+af2GkMqnLLg
         1vgcl3xAzoPrjS7UZi26TvVnwkr+ipwT70JBRMfxoxyQEQVz5F9F9MA5iW7qg3De3wMK
         ZuWQUj1OEd4N7H1T7uYgglmDobUWFYtM1iNp+JVj0GCCMe0ivYuX3TqDrGbl9QbsVPeM
         xv4K1KkeifOZoVMXxj53V3Ocm3m+oUO2SEgrTQ1qr8Lpfk2lWC7TG50rQpJsFst8TD3U
         m8kQqNhDoixSLoZ5DtBozphiWf28SYcqgy7Qd7Y03vrzrqvpzCm1PGqdNWaL/waCGcYB
         nm/A==
X-Forwarded-Encrypted: i=1; AJvYcCUi5Ds1gNVaJfx4DZ4IVju5wyy8xmizdHARW0H82EIgELNKWp90vXIeHgxVa3i9/wTlk4oF8w7sF6o=@vger.kernel.org, AJvYcCV+t8tac5LXcFHuAsAC8GT5DH9NR7mnbI+oHnRatNHVe6jiu446LSeTpwqlRCmbCEK6ni3xM0abZCyS8Too@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48/yKOLsAKvM74+3h6p6fdHgGlxjx7J8L0aKAEp6FKowSGOI+
	QNFmWNj19MgMsMtCAnOhBpBl4gbLWH0HqxWitlQh6GAVnpuMO5wTHoXg0HbvNxEFHWbENLXOUnc
	pue2owgAQxv2K5WhMX9QJRbgLl62RPy0=
X-Gm-Gg: ASbGnct5BhCcbMZpVG21qIu8SaR/alA6NjWV13VufbKewiJThzgE+BSNaNbPk0H7lP+
	9QfQXls9QuwtrB5TE0WoAxLTxf1EX766mR7rJnQzLjtPPAc16wJtyjHWQH+tnty/ES00skyASjN
	NMErTXcIx2E2XdpB0ViCftZ62WiXf6MCzlLYjU25j8KsaPB1klYcXme2H44vB54nySNGe0ciZ7N
	V2PKrjn4w==
X-Google-Smtp-Source: AGHT+IEzey8jGTtk+a+YUu55pw6jWMq3Tw9WNyxuav09P0qlem7Kx2PcxQ86NlHRMdx+LKhPMghrTSiqlBi1DoY3t8A=
X-Received: by 2002:a05:690c:4a09:b0:710:f39f:4d66 with SMTP id
 00721157ae682-7183712cb19mr119298647b3.13.1752798167216; Thu, 17 Jul 2025
 17:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
In-Reply-To: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 18 Jul 2025 08:22:21 +0800
X-Gm-Features: Ac12FXwUTCye4ZHoYDrjE3bOlyQ2BnkuAf_Udi4LIGbspBvecUfC2KWYjP0KkeY
Message-ID: <CAD-N9QVif3PS1Ziw2uZMR=mmVNC5X1_HErVp5ssQncPBiQ0UaA@mail.gmail.com>
Subject: Re: [PATCH] scripts: add origin commit identification based on
 specific patterns
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: dzm91@hust.edu.cn, corbet@lwn.net, si.yanteng@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:38=E2=80=AFAM Zhiyu Zhang <zhiyuzhang999@gmail.c=
om> wrote:
>
> This patch adds the functionability to smartly identify origin commit
> of the translation by matching the following patterns in commit log:
> 1) update to commit HASH
> 2) Update the translation through commit HASH
> If no such pattern is found, script will obey the original workflow.
>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>


> ---
>  scripts/checktransupdate.py | 38 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
> index 578c3fecfdfd..e39529e46c3d 100755
> --- a/scripts/checktransupdate.py
> +++ b/scripts/checktransupdate.py
> @@ -24,6 +24,7 @@ commit 42fb9cfd5b18 ("Documentation: dev-tools: Add lin=
k to RV docs")
>  """
>
>  import os
> +import re
>  import time
>  import logging
>  from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalA=
ction
> @@ -69,6 +70,38 @@ def get_origin_from_trans(origin_path, t_from_head):
>      return o_from_t
>
>
> +def get_origin_from_trans_smartly(origin_path, t_from_head):
> +    """Get the latest origin commit from the formatted translation commi=
t:
> +    (1) update to commit HASH (TITLE)
> +    (2) Update the translation through commit HASH (TITLE)
> +    """
> +    # catch flag for 12-bit commit hash
> +    HASH =3D r'([0-9a-f]{12})'
> +    # pattern 1: contains "update to commit HASH"
> +    pat_update_to =3D re.compile(rf'update to commit {HASH}')
> +    # pattern 2: contains "Update the translation through commit HASH"
> +    pat_update_translation =3D re.compile(rf'Update the translation thro=
ugh commit {HASH}')
> +
> +    origin_commit_hash =3D None
> +    for line in t_from_head["message"]:
> +        # check if the line matches the first pattern
> +        match =3D pat_update_to.search(line)
> +        if match:
> +            origin_commit_hash =3D match.group(1)
> +            break
> +        # check if the line matches the second pattern
> +        match =3D pat_update_translation.search(line)
> +        if match:
> +            origin_commit_hash =3D match.group(1)
> +            break
> +    if origin_commit_hash is None:
> +        return None
> +    o_from_t =3D get_latest_commit_from(origin_path, origin_commit_hash)
> +    if o_from_t is not None:
> +        logging.debug("tracked origin commit id: %s", o_from_t["hash"])
> +    return o_from_t
> +
> +
>  def get_commits_count_between(opath, commit1, commit2):
>      """Get the commits count between two commits for the specified file"=
""
>      command =3D f"git log --pretty=3Dformat:%H {commit1}...{commit2} -- =
{opath}"
> @@ -108,7 +141,10 @@ def check_per_file(file_path):
>          logging.error("Cannot find the latest commit for %s", file_path)
>          return
>
> -    o_from_t =3D get_origin_from_trans(opath, t_from_head)
> +    o_from_t =3D get_origin_from_trans_smartly(opath, t_from_head)
> +    # notice, o_from_t from get_*_smartly() is always more accurate than=
 from get_*()
> +    if o_from_t is None:
> +        o_from_t =3D get_origin_from_trans(opath, t_from_head)
>
>      if o_from_t is None:
>          logging.error("Error: Cannot find the latest origin commit for %=
s", file_path)
> --
> 2.34.1
>
>

