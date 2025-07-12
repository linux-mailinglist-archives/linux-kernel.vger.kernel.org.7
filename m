Return-Path: <linux-kernel+bounces-728522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72DB02979
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48C9544622
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2BC1FAC54;
	Sat, 12 Jul 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="h8pme+2c"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21221F09A3
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297923; cv=none; b=qG00DoZtzQhmFB1tlCdPYbcQaSmlbFO5/Jd5oUPk2MtYRgoC+19NlQpi+H+h0zK0axpU5sk2w5ywLLEIjOCeh9ihUpylk0dP5TURZ8DNYxKRdXP1YW+bpLAGnXZdyFXnul0CwYJ3v8rfRhbHYXdLCHhkwdZug9SOPWx3KIohcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297923; c=relaxed/simple;
	bh=OzWsfRdh2rEvxUhB0pK+C5jZ3YphBuaX/nfPDWir2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Upxog+7axXkf+ZPXmNeh0supo3JCTXmI+8OgdVmSEr/K1KrPdqXxTyp3FKNRDwpBB85WHxtrDn8Y987ukimK/YbsYiyo50jsDKBKd/o4C3A3Rz5nrtrIX74lGg+WrlbougEy39tJAZHMiP/Ip8zDf6Ic5hXNF52U6FCdbbNhLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=h8pme+2c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so518182966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752297919; x=1752902719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=h8pme+2czoxn377wcsYImLfiK0tyLMEzxmutBmuVmkDk8qJ7SiJRAq5ev1OYIgo7p/
         wNpqumQQL2Asw/5KPuBwSITlG9t+kLHi8D5NS7VhTXZZig9/k+8WYDLGQOAgqc9hc/FX
         g43lM0/CMvVn7qq/PZu98O2cSpDASMdUf4Fk83z9KjSrqbEKrPjcXXuIMk+Nr/WBsGhI
         AogW7Nk+6sf7tOCC/TfCd8P7ocZDbnuyg9Tc/+sTvddHGLrtDmotXV58g9uwOMWTuaAE
         4eqrPAsDNcK5CxhTzzmiWXVOGiDgkYxncNQ2uX45Q87k0rS56AicNaeu21nIFjzREgc6
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752297919; x=1752902719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=NPAGqUIGMe99e3VLSaYH3CTqzc5Gxc23+mifXaan1emu7szLEmsgE5BJkeyIeW/LzE
         jIGfSvkoOP4N7mM2W+c7rAVoUshwuJrCztCjQe2r81WUBJMRx3SB4XlO3SV2QycPKwxI
         NdcFrHH7Av430I4G4mtbl4qyuvg6C8TDNh1hsqhw/3Y1LVyqw/spkqQ1JpIpxEVMaFzJ
         muNME8xVkIiTmdww7krAO5122qdnQWMIXYVtHsxxoBloKTL9VRdP93/Uyh8V4ZiMbsvh
         JE5kfGdJQAjy4jnSSKlp3I/4t92oF9B4aG8lXteblMwFjrw2K1/RP9G09MuLps+amamH
         dg0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/NhvLKN2VM0RyT9lYekPnNHMDpTnnym/2msIhFl89MK/XJe4zGKNe3RHMqcuB0yO9OyDaYsGkmID4P5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5PLNKg6kmZgPGnUegC5t+fFWTL6V++lHgIHpjFT3kK1mS16x
	eiE/Eg4JlKckbjZUGonKPTPLx/FijQT1/qnhLLYZFYtspXCjM+WI6GLqd0AwMc4jqKARJd137kv
	oBDiQKxVeQ7qerzVk3VEnbtSBnY9sAumFf03DZ5NYJw==
X-Gm-Gg: ASbGnctsHXJGhPY6vi2cH+xQ4U6IU3PP387eAhWIxa73nNX2aS1Mcha0Va1C8tNw5Th
	X7pv3hT23txwaxPsVXEHHi+tw1AclbddF3GF9G4Mqoc3lihR1PLi6z2z5cnXtw7xWyCqRQfQ9Be
	T8pe6+t1yux3SXsVXgv16ao+D3lxOCRhkXZKKlp4DU2kqa6qkjL9X64u/gY1UYzHPBREUY4FiBo
	jYc7mCwZSM64/4l+PD6ddqHv5fVOJ9IOD4=
X-Google-Smtp-Source: AGHT+IHRqhss1VHoNOeBE3dSH85TBdQyutMEzLaeevjSPISD0eb6jad4c18gV5T9kZxrzRKcHgf2BSQwMPB2TaBTj0c=
X-Received: by 2002:a17:906:fe05:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae6fbc9275emr580496666b.22.1752297919256; Fri, 11 Jul 2025
 22:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151005.2956810-1-dhowells@redhat.com> <20250711151005.2956810-2-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 12 Jul 2025 07:25:08 +0200
X-Gm-Features: Ac12FXwI74XFtOm4i3YUfybrD81gXwe_XUMrlDA403K5FZ8k3_E2nvLf9lzB7zA
Message-ID: <CAKPOu+-Qsy0cr7XH1FsJbBxQpjmsK2swz-ptexaRvEM+oMGknA@mail.gmail.com>
Subject: Re: [PATCH 1/2] netfs: Fix copy-to-cache so that it performs
 collection with ceph+fscache
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:10=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> The netfs copy-to-cache that is used by Ceph with local caching sets up a
> new request to write data just read to the cache.  The request is started
> and then left to look after itself whilst the app continues.  The request
> gets notified by the backing fs upon completion of the async DIO write, b=
ut
> then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
> set - but the app isn't waiting there, and so the request just hangs.
>
> Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
> notification from the backing filesystem to put the collection onto a wor=
k
> queue instead.

Thanks David, you can add me as Tested-by if you want.

I can't test the other patch for the next two weeks (vacation). When
I'm back, I'll install both fixes on some heavily loaded production
machines - our clusters always shake out the worst in every piece of
code they run!

