Return-Path: <linux-kernel+bounces-881019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA3C27386
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A5D4073DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D932F74B;
	Fri, 31 Oct 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl1xHIOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899D32D0CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954618; cv=none; b=UladxviU6PTvbF2vq24ZhbdbTU0md0Ad1RAYUdpUH1AD+I5/NC4RfhtTPV0BO/A0yZwMmWiPBXXVMB2cjydjtdyi3KTmQ8bR11gcfJS/6p9X7JdM9WtehVXOunMJpX+dLrNyMXEkupVRzixAWJowyWmifXTQ4b5RdCynhv/15tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954618; c=relaxed/simple;
	bh=/2/ajoMcL0nJ8XaYHk8GNFJXrKDu+Fo31MBZehKtJwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx3HuH7ddR3cCzgWdxzfzZnPmQIF256LwvdLlXvBXqghxmhAn2ZlkioOwsKNsJLVaLfEUUN0RxmC487yCcy89gKFUNzK3XhpTqR43eQUk+oMEyz9aZI4wPv1+Pmoi8dux9nKiTDQTNGvPLOhYU77tiV3oLZJvXT3aiV9HyuZQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl1xHIOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A525C16AAE
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761954618;
	bh=/2/ajoMcL0nJ8XaYHk8GNFJXrKDu+Fo31MBZehKtJwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dl1xHIOEsevKwhp4hBvf7FnHJuHwUXF5tMIPL5VvdrN4G7KMwF/7tF791/hzsWb/d
	 PhS11YZFfIXuxaX9as+Yjhfn0sKWN0qlpCUnOYxN3C+HXVPBe9cO17Eh3IX/8ELvuG
	 hKdEA7KpgVd8d0xaE3G1Hf7f61Z/E2QBGPqVUfPtCauPIAUc5htcQXyHeQ+F1wbPcx
	 Jxu2XWXLhAHXmaD+5kKvTPEvhPUyUTM6Y3ytzzTDSXy4MwyEtR2nmPUuRMviuZSXrr
	 Buf6+sFXvuBHvESPq4iSyJKdcYeyV3JugAcAaBjOTaLO3cPgrQ/S6XyhTPkedZ2MAz
	 1m7U+cKuzRlTQ==
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550eff972eso1964545a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvURMOSD5qtUR0m5zkW12/ikoIPBcd/qNcWEqbjBFT6jbHYtmQtexi+GKEce4/FcPLSrHsNocfXblFmj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNPIRFWh9nWVQuzvakb/irF5vXjCgETQuFYTGV9zl8xOQOXLJ
	wjhQ2hMb9Ukh2Q84cT2H2EmR1WHratVSd6sE5TYSGiuTN63sbUCUwx4rdM5VTeRhxpV4KNPV1wT
	OTbTbRf6ohT/KPw8Rn9mARTO644rTL9M=
X-Google-Smtp-Source: AGHT+IF/IzsfRTe4tVhaCIKS8r/3VLdW2aUi6RokBL0QcMpp8EEpsvKRse2CEt0IwBh6tkQ5GvlWCyM3+iFSoVFVEEU=
X-Received: by 2002:a17:903:22c6:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-295513221b7mr16477645ad.44.1761954617741; Fri, 31 Oct 2025
 16:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
 <20251031101700.694964-1-yanzhuhuang@linux.microsoft.com> <20251031101700.694964-3-yanzhuhuang@linux.microsoft.com>
In-Reply-To: <20251031101700.694964-3-yanzhuhuang@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 31 Oct 2025 16:50:10 -0700
X-Gmail-Original-Message-ID: <CAKtyLkE_Jg3Sjw-HBKK1aZTwv2a6wM8BWpBZ5XK4aM-6e_rT5w@mail.gmail.com>
X-Gm-Features: AWmQ_bkLeLDp6SONSBbYTeZsktbD5GFNx2gqFUxFKj5LrtAnbBK3sYoYIfVNLm0
Message-ID: <CAKtyLkE_Jg3Sjw-HBKK1aZTwv2a6wM8BWpBZ5XK4aM-6e_rT5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ipe: Update documentation for script enforcement
To: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:17=E2=80=AFAM Yanzhu Huang
<yanzhuhuang@linux.microsoft.com> wrote:
>
> This patch adds explanation of script enforcement mechanism in admin
> guide documentation. Describes how IPE supports integrity enforcement
> for indirectly executed scripts through the AT_EXECVE_CHECK flag, and
> how this differs from kernel enforcement for compiled executables.
>
> Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index dc7088451f9d..3f205d7dd533 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -95,7 +95,20 @@ languages when these scripts are invoked by passing th=
ese program files
>  to the interpreter. This is because the way interpreters execute these
>  files; the scripts themselves are not evaluated as executable code
>  through one of IPE's hooks, but they are merely text files that are read
> -(as opposed to compiled executables) [#interpreters]_.
> +(as opposed to compiled executables). However, with the introduction of =
the
> +``AT_EXECVE_CHECK`` flag (see `AT_EXECVE_CHECK <https://docs.kernel.org/=
userspace-api/check_exec.html#at-execve-check>`__),

Using url here might not be ideal, perhaps change it to
:doc:`AT_EXECVE_CHECK </userspace-api/check_exec>`

-Fan

