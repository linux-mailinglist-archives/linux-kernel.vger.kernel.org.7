Return-Path: <linux-kernel+bounces-896381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995EC503B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF34E7193
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317B288C08;
	Wed, 12 Nov 2025 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTQTafqI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32B27AC4C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911986; cv=none; b=sBWddKGEwmd8sB0ETe748Rc0imTwMKflzzognnbN3MLZ+DTcW1U3L/iInZDJ9f6f2rYLpsBBzE3cnhODFQt2lWa3oJlYTJ4IerN9bp6jYozqOD5dTXxLO6q2qbsdWG2S0gLJE2PUCbtvgQ2+uCppYVvFT35WR34MLew+YK5hExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911986; c=relaxed/simple;
	bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eceKrdP7bRb0DH7qGZWpuYwsg8/d2KIUEh7TzreXpdBZT1BgyBgcwgBDx2wBd8BdxxUtniue4n2oR7CX81Sv/vRlL9+LVW4WQWiQ2x96nQxgG/wSilp4kfd2YP1Tfkasiuv+pXplyBfMHLw4NJqGQZjYiA6FjlUoWeRWUw7z3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTQTafqI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso395526a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762911983; x=1763516783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
        b=gTQTafqILKv2gJJzkyGCJM1V/VPVQlGUnAszGi9hAEV0f6tHBtWdR7tCX4il2WyVkX
         iyvOQVMFAIdDfs6M2P/GTh3jmlPWO4BY1ENTeAV3ecBy1cPtDpcNJTccF1O03j6i4erB
         m4MFglA0wVgS3RgIfGllW+UkysU2nKE3LsZbd1SBjMcD4OMHhaz15QcAj4rxOkoY30j1
         4rEt/CesFcuMvUk7y6LRz+UBFK6wicEIJSj5InH6gDF7jC+PPgzlJ8sLh6CKs1lQPw1t
         7SlEIyJgK/ZwnFkHtZZu5AnQjCnRwn0i27X+M8a5KMxCGB6l4VzHOggsBTnzY5jSRK3j
         8FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762911983; x=1763516783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
        b=vcmYrk6pE4uixKefZ0omWiivAaLZH4L4yL80LbIcQDEk0LI9VraBPoCFyfxoPDjV1u
         vvenDYUe4F/Wasfyycau5nZ0gcqJQvMazZtjuRztr16AVEBcrRMpDJlTc4HTFSRIZAKi
         5aBuP0eLgqX0yCURrMAulT9U6TtYt0565/H/bzlv1MZsL2V6r2ogPLWBopGK3Ma+BgeY
         t3gW4cZuc6uGnbFxtXmdmKDLSBWdTaq7r9KCHEjGqN3n7gqCB/pjhhS9PalNxiw1mOr9
         oMkYFSE/qNh9A8NGN8UrnhnEmqrjohvGlK+zG+oqKLB7ykk8G63WTUTkylvXTTe+qmSM
         Bz8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHToFloTHEs1rd3/h9kKjbcwhh5ICYiSL2Hsz+ElEJTw1id5eMlwh1cHzDA15Jfen4/nXYJuXzz8oGYaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9uNQh93KWWjnq1IlP+eCQfTA2DYVYw5LWm3POxCUcsTA1ju5
	5rVKyRscZ6muX3zQC6AsnIPpR5jSaZJfuCvy3b0brK+JzXUG2jpSvalP4zpGedAL6b9KTtXuqLJ
	DV0dFeZDDg7JDUBxYIAtlzXJOUywFnDF0d+a6Djh/+g==
X-Gm-Gg: ASbGncuWsheszUPmK0sJjD9aWW9W4nfr6h73i3hqkD0TVyg8IKdWv3U+lx8VKxKpdq9
	4HjGWmsNqc4SHLnnkp6weyj4/d0YkJPJw7Hjfd5mxLRQVqd4nIlCqWkNfBgL6rcWW4UwnQaE1nc
	bk7ylp7VYiqqbSi7knrM4i3zUpFod5uHDFhgH5VNR7vU7xbBnqh6wdU3B/SPqzTlZUHkLcUgq5/
	9Dv2dSpuI1Y5BHL1lun03i73E3yPwXZhkLhByJa5PTpjIH/YHv15r22R6Ul7OALb8if1XXe
X-Google-Smtp-Source: AGHT+IFf9VeeFncXYo3f4CCqReWeYkEYLxn0BvQvtjwZM2iKjZyMB5M2tztDvxrxzrMOijaP0r714s5CkmVrJgZ+mDs=
X-Received: by 2002:a17:907:9727:b0:b72:de4f:cea6 with SMTP id
 a640c23a62f3a-b7331aa95bcmr118977866b.48.1762911982618; Tue, 11 Nov 2025
 17:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111135432.2143993-1-dolinux.peng@gmail.com> <20251111182820.4b44cc8e@gandalf.local.home>
In-Reply-To: <20251111182820.4b44cc8e@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 09:46:11 +0800
X-Gm-Features: AWmQ_bmgZcr4beak1JLM5eV-k5OGp54yWXF1Gvxb13oBy5WlTpQJLVMkVldYrAo
Message-ID: <CAErzpmt=pgTh_MqxFvnnZt8HOgs_g3nFNjPWuXv0Sy0S69xPsA@mail.gmail.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Nov 2025 21:54:32 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> BTW, are you two people?
>
> You only need one signed-off-by. Which one do you want to keep?

Thanks for catching this. I'll fix it in v3 by keeping only one
Signed-off-by - I'll use my Xiaomi email since this is work-related.

Apologies for the oversight.

>
> -- Steve

