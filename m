Return-Path: <linux-kernel+bounces-823757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50758B87622
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2263BC18B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DB2777F3;
	Thu, 18 Sep 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD17hU+6"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69ACBA3F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237980; cv=none; b=eupv40yNTPGFh+aP75LUfatSsgQmd+9FCEsqDLNUAvSR3SDwpgTSSjqNk4VovtfL0lE8JeeSvTcKJda3KyGoXZX511//uFgNhmAlFI6ZMM5LZZ0kJbSsII+QW55A/wLQBlA/EqxZBCt8SgHCmaWeSpQxGJU3nC8R5XTe+vUk4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237980; c=relaxed/simple;
	bh=H5PSGNQg7m2OCLkaiqh76S4CSMraZGwjuC3D6mjIfnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5rIyAEwem1XPwHcf6uqHilbISQlg6CPjjflmNZBhV27BqFifn+BRZBAK6JrQ1Z9v49hVmONIuBDcpL2dRDo/iztjJ5TtYkug/7LZvPMq2Ra8ZYDxspzfuNh8EnShbcdyJmBUifaqp71D/Y/NQErn8rkmwFA62UdRjDHf3LWFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD17hU+6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-321289dee84so757775fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758237978; x=1758842778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5PSGNQg7m2OCLkaiqh76S4CSMraZGwjuC3D6mjIfnY=;
        b=HD17hU+6GxW43R/4lgDE7gv27DAvQK16igWlpkDdMhoGjL7uyAd/w1Z+bYqTVcBvgR
         g1jd0zuQpPQbkv5mc7cL7MTIA0LqGJhUCn3MjfT3WxMR44lDRHM8Glx99Zb1+hDxubZg
         /ZX/yatWQPvldC95bLZHdu3zjQdxFm+7U+BbBQezo4O7+OuD7WrqyXDJkxiFXORXa2p+
         WvnD5Br9i0x4Ao8+Lxh7nACi97ElOs+xkanqBO7P9bRLljJUfrW3WSMLlebJ3xY91Cs8
         DdxBITakrRzDMbwIEG/1jPyRRFVN2PRo8dnrm0KVYZKyPUEBFjO4Ptr6YQUsTVDo8uU0
         cLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758237978; x=1758842778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5PSGNQg7m2OCLkaiqh76S4CSMraZGwjuC3D6mjIfnY=;
        b=kk1zv9Clmdy6IEdDZwS/c//B3kRyq3H0SfRxA0vrKWORI4koiuCSEZT9c2SoPyWskJ
         uVAxnSgjiXpPkbhe/eqw1FcRc5rPDk1KRnUgwH+XMxdLiN8ljeXOJmTfD/zpjPblbFq5
         exOOjOiKwvYZIIsgvW5U4dLuxxC3K/IbQUyiR6qmODT1KItS0wGH7hXa/tZkyogf9uA3
         E+rlIFFZYOVwXNucTZcSi4HJq2dNDoqTERXD15CMCJxzQFVZgq9YxtoiU69DAvQkQ3hX
         4PKy9o7X++7izGZUwi+qmL+l2Fx+zU+bCW8dH7xEsMtS9//WJDpK6hcOyK3zsJV7mRpy
         dpeA==
X-Forwarded-Encrypted: i=1; AJvYcCXXAsew0I/0aM9RC64UEdOsww1Myab3nm31dKLTddG9T3VMq630mdMQH7DfPlPumS0O0UOXZwxVporgNA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCyLBdZ5GItQHEQIpr3gqKbIqwy4ArLaY5l+yAE409tiViDsg
	OdnWUV7UNk1t8mL3m9yh5WEgiNzN94J7uYtsI0CRv91VDzbyjiNWV3z8DqiPxS2D4kLKeqmPPaX
	rEBtEErIa3GK4K3OieuWDPz4UnQmbJpc=
X-Gm-Gg: ASbGncux6i3Q4x3EVDVd9/Q8LhuECQSR5j6jjCz6jn+8hZn+8oBAsd3fmMGklJk7S8E
	MNhjMnovcxgpgrIDMbGAgIy44D0ytEzyQJWy8Tp9dSNfPPUgfRi221uWgB6A8ChPmZCsnMmLmcO
	AJtKFSKhxlL6uYLTpKDKssxGCLWObUUxU44Lo+/Hc4jxpFgzbU/kTwVm0OusSjV62G0nAaZZ+3K
	QWo/Fco0mqOi4Z4ZCPjJUduelM=
X-Google-Smtp-Source: AGHT+IHISKOMtgOblPTNaADmYlAk2s8JU31GLuku5DsHMgMiTPRy4iIB4214Mw+FbBVlWOykCFYhHVNImQjchzFXrMM=
X-Received: by 2002:a05:6870:492:b0:314:b6a6:6877 with SMTP id
 586e51a60fabf-33bb66dc2ffmr761494fac.45.1758237977767; Thu, 18 Sep 2025
 16:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918125547.380088-1-joonwonkang@google.com>
In-Reply-To: <20250918125547.380088-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 18 Sep 2025 18:26:06 -0500
X-Gm-Features: AS18NWCg4UfTPpKdmlyH1vSMbFdrl4Sh669Tg4AIfgZZcWkAxCuTnR27ibT95eY
Message-ID: <CABb+yY24nzXw_9+CAtsvV2L_+=8206u+RYCyqPSmad9fO7gGEg@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
To: Joonwon Kang <joonwonkang@google.com>
Cc: peng.fan@oss.nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:55=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> Although it is guided that `#mbox-cells` must be at least 1, there are
> many instances of `#mbox-cells =3D <0>;` in the device tree. If that is
> the case and the corresponding mailbox controller does not provide
> `of_xlate` function pointer, `of_mbox_index_xlate()` will be used by
> default and out-of-bounds accesses could occur due to lack of bounds
> check in that function.
>
OK, so we want of_mbox_index_xlate() to refuse if the channel's index
is not available, which
will be the case when #mbox-cells=3D<0> in dt and sp->args_count=3D0 here.
Fair enough.

I think the following details are unnecessary, maybe drop it.

Thanks

