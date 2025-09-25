Return-Path: <linux-kernel+bounces-832661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FCBBA00B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2B63BE75C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999202DE719;
	Thu, 25 Sep 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiyB1Sw6"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5622DBF5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810870; cv=none; b=R0FlJF2r2WWA+mWLGh+iYyc3NgxtIq7+ITnV6AsP97k/YcrjZJLFO6m1FYQKqk96aCMFtYYWaF8LVjSE+yABR1lYrT2lvrs6fpvmkaEMaGz6myJen1lZi5Wavz1XsX7MKk8bnpQ3lRvzHXpmgsb9FwOYAuCK8qbudHk8NKCipHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810870; c=relaxed/simple;
	bh=6XA+llkjZZVH29f0iycatx4vb1CIaytfaB6lMJvlB8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eliaRC1cc5kss9guqSzNBC+tkD5OHK/xLKNoVCbblr7RcG4FnBnymIaUsAIMmHpafNo0nGlqhd7rhl1vvusw6pmFWTHN99bDYLsn9mdgGleYdyf8s0w9tdg19alh/jFEUpC2wjFG3qskTFIe6fjyNGU+AhAA5ZHH/3qrLk7i/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiyB1Sw6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so999774f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758810866; x=1759415666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlmWZnzTQZk7hQJHDjRsw6Fn5BINueet3UHk9KQ1rXw=;
        b=JiyB1Sw6yUHbhPNARjgB4h0+sV8ZsDI4K5+GauNR+yjB9Z+0sSh+OCV6cwu+Zmy58A
         2K89axmqBy3UG31xs/Vn1wfEY6b+I1vuUw/mA3teMhdB/VKWNd3vDD2hqJ0pry5S6kuA
         kKFZlxp4k8gKWRgjG40R9/E+nahiBh4By9DtI8wLbMC4o15IiqI59nyDw+4poxadzpQ6
         TcwUfPORCj4cIukSELq+Ta3E+9vgvTyxpFcilxiTZxDrSFYQQ1+6tFAl581MaJiwmlns
         CG33l1GwMqQdNX4ReQ5ccDlvPohTWUGTMhRE4gIPz1ysNXQVpUiPz5tgSccyKo8CeAnH
         y4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810866; x=1759415666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlmWZnzTQZk7hQJHDjRsw6Fn5BINueet3UHk9KQ1rXw=;
        b=hoNzB6kDqbnEvQUCLiW7GulJQcravrXKtLmq7nU9ZbwKQWjg05Mx6uQf7BuNHztrN0
         c9okzEos8tXfOI7FriivL6Z+UGLNh0O80LNtoBqx1Iclk7O8lJO2MGl7oVfztPwpdA07
         nTiz8VN7QetzafDUPqp9moAvhcX/tGBXQEJYhPUVxGzk8A+RAHWK1hSeEpbfCtSBzpSJ
         IYeVcSIlK2KmQlOxwbl3KsxcC7EESTzSOoL4kex5kcJeOKgx99Ez+fONDSnFANNa0TXw
         KYUCsojpjHHUP2MXS4tJY/yk14gZLP3Z2X6CdbIXT8vMDvdaY0KH6odaf7CmuQQJi/Dg
         sRxg==
X-Forwarded-Encrypted: i=1; AJvYcCWlBTmWr9fRTrxOHC28J+9RST3dGeWtEckNYCr26bZzLaxp5o/2kloh6nxx8UMg9HG0gml+lHWQfPvoueE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJV/cfW8RG5nDsUPxvWt6S4rRnHjlyad47JDY6SpLkilnxTHz
	0q9dBDpRpYj520jq2r7O4v9fFjh7hgKXxIG+aleOsOp3RJPN2QvFMjJM/KCZBbQhiKWhfxbLwgg
	KoChWypskxQgMyKnWhPghzBitCK82wCo=
X-Gm-Gg: ASbGnct/DWynOviEhfO8+xee9pn6S6c589Fa6oT4+8v25JDGq45jeO3yM+qGB/Gk1Ut
	hsPrQXShS9nrl8BSXYbV/wD77t+KCQsdE6CLceCUR1JjMMl0n9sWXwVkC1K5TrQ8XgOTS661JU7
	vjrKF0qqPHav/NeRU9uS7+GAOJeVU/y7S2PDfs2bqNbI86Fbh/Vtq9DX1vwp3r9iAKJDxGMhHU8
	DG2pw==
X-Google-Smtp-Source: AGHT+IGY9M679gafputQhuXv58U54d1hWGLNXuPzatEJA13krdUY3caj/cCKqU06kl7/8uBnZ3uP82zoy5jzM0Zo1PQ=
X-Received: by 2002:a05:6000:2486:b0:3d4:f5c2:d805 with SMTP id
 ffacd0b85a97d-40e4458c89bmr3769232f8f.16.1758810866223; Thu, 25 Sep 2025
 07:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNVMR5rjA2geHNLn@sirena.org.uk>
In-Reply-To: <aNVMR5rjA2geHNLn@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 15:34:15 +0100
X-Gm-Features: AS18NWD8ZUmLb0ORW8a0yDbsVq0TSmHChIah2vxBghBU5_0NKGLYU8EJzRAlptA
Message-ID: <CAADnVQLcNWCsazy4XudB4EPaqvdtea+d8w5q4R5MsvRJ4fmOmA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:06=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   kernel/events/uprobes.c
>
> between commit:
>
>   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when =
ip is changed")
>
> from the bpf-next tree and commit:
>
>   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
>
> from the tip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc kernel/events/uprobes.c
> index c2ff256dd6419,996a81080d563..0000000000000
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@@ -2741,13 -2765,9 +2765,16 @@@ static void handle_swbp(struct pt_regs
>
>         handler_chain(uprobe, regs);
>
>  +      /*
>  +       * If user decided to take execution elsewhere, it makes little s=
ense
>  +       * to execute the original instruction, so let's skip it.
>  +       */
>  +      if (instruction_pointer(regs) !=3D bp_vaddr)
>  +              goto out;
>  +
> +       /* Try to optimize after first hit. */
> +       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;

Yep. That's exactly what we discussed.
I'll mention it in the PR during the merge window.

