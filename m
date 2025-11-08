Return-Path: <linux-kernel+bounces-891663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D5C43307
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C68D188DAB8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6826E16A;
	Sat,  8 Nov 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DiUZmm/U"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFD26D4F9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625652; cv=none; b=W6op+cX0nYlsz2XFDejPtYMdhYkPJyWgMqL+70XE/WAIUpt5LGvgkuzqiT/tDPio91crCm8+aWKVcQvpfPMCcLqBy02wAc/7UPPFZCRfHVKBTWBGaD6jRJxmdgacHyagXjNcyDMWfUOu/SjOlrwcMBmS7fyvd+jEkLUOT236v+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625652; c=relaxed/simple;
	bh=HXLYSWisfIRg/IZEGEaCxFtj3HbKG4twWmdqzwXU56M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8qN9Kf56KTmA9sv87WdcS0mzMhR6KZAd+gdVKMgGNB8GM686MkFFRzrskjIl0ozvnDYPI8HASNo8CYhrYpVSGPYGkX4M68H8t1QH1Z/jOxJpB3ywmiipInLKU4Wmo+NcGPFvGbzHgc1lGtbgeZkYHCMlmyOCrLH8glrJGHlLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DiUZmm/U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2797264a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762625649; x=1763230449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q3WFXvp3nzw/xfIhFbqypMckNDbnX8ReX564Qc9Enc=;
        b=DiUZmm/URky2uJk4p6TqUg8JYsDKX68Wlio8SnlETKTdQV5P6kVnCYCc5A1HmG67YR
         dPiUYtngGF/IDwNQ6NwhgqBwOhXOYiaqO0uCQRfn5M9IdfoUIQgMTGvaEoveSIqz7QY2
         7JROIPuVD9XX7mItmn63f88nMjTaf1tXoJuePaR7CmGpQ6mwLCqjzLU/W9/Klsi/YsGj
         0sBDeVGvKiGmqv9QLtp4wZzCmvM7MyBbxeWg5rNa5xbvaQa9G1U9iS6rRQzHT/b7rIlz
         uI8UILJXP1NAibLw5jSnbQaDKk9FyHv4szQaMnO9f7DSzJ3E70mlx2/ZpeaPs90EEHi+
         o19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625649; x=1763230449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Q3WFXvp3nzw/xfIhFbqypMckNDbnX8ReX564Qc9Enc=;
        b=VlkYFhhGl86v9Pm1P5VQa4Wa12WYetROPzDgG003Xofx5LK7tM9fT8XxWQEZiwR5xq
         gqPM5AyPxatB6Reqh/MGwnSgr01YMIIT4HNlAbDXzeXt2VQci9sJ0bIgYxD+cEp3js/a
         zffCE8L0i3SNNNFcwKtExiM6GjFSCLjlaZ4jVCt0QECFDiMBnl1R0GYJB44k8ZdKeowT
         h9NgczG3/NSNA5IHtMVjh5QyOAhCMXZ9TOSH1Eu+Y3Ik7xcAE8IkLQCvjSD4+Czz62l4
         rNqpICP3MPeTbNDWLtnQi+F2ZnPCFURKIavctaF6DbBgGopoRgKBo+UPYjIF0MfcPhVi
         ZvQA==
X-Forwarded-Encrypted: i=1; AJvYcCVKBwiv0vpjizFNKhQ3hlRuSG//tr8REMXdpjgMjoKckKxIm4kYosaznf5xZKFUyQ8E3ROuKE8WBWnFI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49GjcGVEIBFHLfAxFse75yYDfuSOudH+Ks1agPTt+pOpGRybr
	TO+ljpBJUtDbCYmlkxSgs2AeyuwKhAaiZA33b86HxZat8bO0GKhaP5kYqBOM+PzEDg2pV2SJuKj
	ur3CdqFDfMFgY9KlTIYrtylWF4cIdnehw2zkPvjqrjw==
X-Gm-Gg: ASbGnctL2/GWdAo/DBIGE/Bqxn43OUZM6Z1TATzGXL9mjVaEck3BcVe1OBHjyxhzNAA
	6nFS5ZMN8jHEn5gCsYfZYhX7t5z1CTHUZHbaXcnBfax2KPFXTsRE/8aWvF50cVyjSGV2QLr/f5y
	1TtYKK7KljfEDK9nBe6cNuNZ88xt5jXXYF6FDWKy8Sn2no8Q350cTONaudud6YEq2isI2+ysXjs
	lBqz+nvJOoqF0+AqdldSDe+/k7i4hNsLTITAS90rtMaikjTxJGxbhkPyBZ2g3otAH4uNu6xRGvj
	f+DpwyBPI8TVVbzL6c1dqRNdZgeQ
X-Google-Smtp-Source: AGHT+IGnxIvGVB3DoG73/LoR1IZOJvd+jikoooj0blQZKowrXDzv2ZHuSFpnulnp2McWHadhftCSnlvUuIh9AczGGLk=
X-Received: by 2002:a05:6402:280e:b0:63e:405d:579c with SMTP id
 4fb4d7f45d1cf-6415e83f02fmr2267675a12.29.1762625649247; Sat, 08 Nov 2025
 10:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com> <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
In-Reply-To: <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 13:13:32 -0500
X-Gm-Features: AWmQ_bn1c7HhzSfiUpQMj3X6qTh8tFK5YjykAbxye45PZog-6bB9QqhpzjoyA_I
Message-ID: <CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Live Update Orchestrator
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:33=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri,  7 Nov 2025 16:02:58 -0500 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > This series introduces the Live Update Orchestrator, a kernel subsystem
> > designed to facilitate live kernel updates using a kexec-based reboot.
>
> I added this to mm.git's mm-nonmm-stable branch for some linux-next
> exposure.  The usual Cc's were suppressed because there would have been
> so many of them.

Thank you!

Pasha

