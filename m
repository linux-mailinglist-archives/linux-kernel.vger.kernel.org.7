Return-Path: <linux-kernel+bounces-720839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D044AFC103
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1901AA6D50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073322CBC0;
	Tue,  8 Jul 2025 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gga3JszB"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817121DD9AC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942737; cv=none; b=BUaSlBtC308junRCY/tFgYrSbxsicr8q35rVGmSv1517TXQn78iNvWO3neJybtTiLKvR5o5LXBK5S6NLTIexUmyOhZ0z6FytesMeVQOrSbbNkN3pT4fVTWP1lW0KmiJ0GQ0qHv8WhGzvrXVspYQ5YdqWcz8iW+jL1zZhgjUlD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942737; c=relaxed/simple;
	bh=aUMMjB+yn4mSEgqXKC698aJON3QG4yYWMuKTKFB/0kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLczeuYOENraFqeeSKd9Cq6ONawmjhpCOaaHvnOjOSvR77LnseGoWK7CGQH4ai/cf/ypoFGrzNyGZzCxV9qzJqQxtQWNQVbI3GpWu5iSM60Tg9mxZTe3eQMd+feRMZzoxrYTLIPh7tcWmEGXsaoItCds1zguf3DRhJ1eLQt5a0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gga3JszB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3c6b88dbso25930327b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 19:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751942734; x=1752547534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ/NiNUPsy7bq8yRlo+N7RrKNim2+iwf68n6XJkJTqU=;
        b=gga3JszBe1+ZUdewSLprTGFloPNe7xaFU4ijUOmCJ75ENlEqPH3Ss6DurCaQ6VxqJg
         /JhbLuw9x2zIHzwmdRAwgUxfjrlQ56o8srONhdjuW6mr1oBj89VSrlF9w3nmks5q9lYi
         8Qzx8m3VRAdCdRpLJkxWD2PyAuWM+ZNIU/HoX4ejtzFat5F6BbKAqz+6r9QoTVoAX3Vv
         tRnW1Zod60EHlTMqAgIA5Gr0N6JFLTEMH5DPai4QPtlBqVBNjGDesnBBmdf8k7qQZKID
         ao2nMo/Frif/PdslDXdZ9YeaP1N5KTzAK8gt1OD57W1Tx/3GeSK/E1FErnnUOTNk1EPo
         wfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751942734; x=1752547534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ/NiNUPsy7bq8yRlo+N7RrKNim2+iwf68n6XJkJTqU=;
        b=i+KFoqhtB2wTnRHymrp5zJl/shdLVR4HH0PDKYgc9vVmA9DokLHwDwOgXBFGlwELAM
         yDyjQ547+U1SERnyMPiogTsh7MitE2x2hf8xDTOyDyyvyHel8SNAjtsBYAzfeX8UoZVT
         QLhrU5Jem5/11JH/O7ZSlLDbuVwhHcXaLlpQ3TbU2/CPjPQcepunxW30vLyk2tJfcOok
         jTto0XQIATScS6OhmEk6l7HSZJM+YWXLxbKzDWhCdGmAvkfdyU7inaz7MhPNGf73R8tn
         pRw/wpgYmzbd3wkiLvW0lr30zJNovTFhkKQYGW2hDOe5EK+f/5YXgdfWsWBR7CBNCULo
         Zd1w==
X-Forwarded-Encrypted: i=1; AJvYcCW0y4KqV0UwtAaDQXf0gGUbEuW8mWc9YNTG2Dy8IJHrr2foEObNFoy9ThrRt57YE0XaMdTF2AtwgnzYNDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRfvHSnDk6t1/HxOHato3rhAMliWPowTb95Cj1ZbeVbFlr2Fy
	YFno7slwcPfZMk0ZZKAD2FCSLSAcN8o2UrMv2ZHi0kpTmgwgmsBbKqmAA1nY3oGDzgd/JqCeJTv
	3kIGHLh85q8E0KP9gmjxqoDLNhb9jr1yK+53hKjWm
X-Gm-Gg: ASbGncuzteTLDQLGaYDkc3uMfjWTY5QwKWVOGpvuiCs2JeVUJc02MxwLPVpTKSQiavg
	cDiVJV8gMSf+fNLTs7/H93CFd/E2vmVsaEKzAnDZZiJJv2UAr497/FEAmxw5huzp1aQ9KVXeoEV
	fdgSV5REGkGLAOMisYz5sghQ525MX35KrgxjTtcEoPoCQ=
X-Google-Smtp-Source: AGHT+IHWCYgBwFfnvQ04g7x7wixvMXAER4hy7VugO4JmRhjOft/6uFE58Yw19AkqzbY/9MfAI0j4ZrhQW/BRI9ZtxG0=
X-Received: by 2002:a05:690c:700d:b0:715:952:e8d1 with SMTP id
 00721157ae682-717a0414aeemr15148317b3.20.1751942734451; Mon, 07 Jul 2025
 19:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626191425.9645-5-shivankg@amd.com> <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com> <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
 <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
In-Reply-To: <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Jul 2025 22:45:23 -0400
X-Gm-Features: Ac12FXx48DIUvMS0yWAzdQUJMMUn3Ep5a8fVtcwuwTJZh9ePscSPqgGP30FbUrk
Message-ID: <CAHC9VhRUkKWDc39BAz6uzjRBt47wDCNkzfV=z6+Tb-RznfycsQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Chris PeBenito <pebenito@ieee.org>
Cc: Shivank Garg <shivankg@amd.com>, david@redhat.com, akpm@linux-foundation.org, 
	brauner@kernel.org, rppt@kernel.org, viro@zeniv.linux.org.uk, 
	seanjc@google.com, vbabka@suse.cz, willy@infradead.org, pbonzini@redhat.com, 
	tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:38=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> w=
rote:
> On 7/7/2025 4:01 PM, Paul Moore wrote:
> >
> > Strictly speaking this is a regression in the kernel, even if the new
> > behavior is correct.  I'm CC'ing the SELinux and Reference Policy
> > lists so that the policy devs can take a look and see what impacts
> > there might be to the various public SELinux policies.  If this looks
> > like it may be a significant issue, we'll need to work around this
> > with a SELinux "policy capability" or some other compatibility
> > solution.
>
> In refpolicy, there are 34 rules for anon_inode and they all have {
> create read write map } -- none of them have the execute permission.  Of
> these, only 4 are explict and could potentially be broken.  The
> remaining get it due to being unconfined, thus can be immediately fixed,
> since it's unconfined.
>
> IMO, this is very low impact.

Thanks Chris, I think it's worth leaving the kernel code as-is and
just patching the selinux-testsuite.  I'll send out a patch for that
tomorrow.

--=20
paul-moore.com

