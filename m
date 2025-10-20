Return-Path: <linux-kernel+bounces-861393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99053BF29C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64F404EA715
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE0330D24;
	Mon, 20 Oct 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCTzRP/P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724ED330D22
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980092; cv=none; b=ZmXhQKZw7Ay4NKbbcJAcDWKRtixe8hYtzt8awr2HOvY54AdOG8UlSHsO25MuI24Nc5ejX8H05iJACME3RTPQNW/MGST2+YOrD1CYYHTLetn9UhjVzP/5VxTahZUvH49F0wC7WYMlVRO880+tlY1m+Z7FnsNvrw7leiAIMJ8S3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980092; c=relaxed/simple;
	bh=++JBAp2xm1Bl/YkWLfXigpQePNZ412++Qg25OLfZJHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwF5uVgTBeS60QU9DOzbZnMixOXansCrNXLFP4PYc4ghW4u4wgH6R2W5/uRzJWyMr8Nwm1yeLj98SyW8qAS2/C9c7rmK6qdpy7imFWB0JAdikdr8NrNi1qZB6BAmitQoXFBdqyxYCnbrVT8PgsGRbn+RBrFOabUq1tOn2OVJXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCTzRP/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760980090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pux7rQuDYhVQLMQRoejdWlthCyHXYYQvPav2QQo4Hto=;
	b=QCTzRP/PZO5cExc6xTYcFMUCFfhi34DkfmItFm6FvkOg1L0lyx3cFqc6PHw3HdVIwIUoWL
	68Pbc7voD38wAP/MBJEGWVdeqSxoxpMOc5fDI9aejLXA9gtf7luT78f+l13gEUNMOS+zKT
	hcfEormdqVZQQjtLjDZ1ckSeyeZIgsM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Ko7QcETxPvW8OQAGxZ4rTQ-1; Mon, 20 Oct 2025 13:08:09 -0400
X-MC-Unique: Ko7QcETxPvW8OQAGxZ4rTQ-1
X-Mimecast-MFC-AGG-ID: Ko7QcETxPvW8OQAGxZ4rTQ_1760980088
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87a0e9be970so170542916d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980088; x=1761584888;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pux7rQuDYhVQLMQRoejdWlthCyHXYYQvPav2QQo4Hto=;
        b=ZH4IeZOirm4CtqVsF+OWQRo1xnSxSpa/DbTAJ1SEPD/bJhcE2Py61f/Jc0+q4bByRS
         j4uUIrvtcpAdqTBCLUTNzox/aaBPiD0opBEpeK6fg1XaenFkYplbqzUMYOR2t5uDGAPG
         XqTgbG3mrOOt9RDWwoJ6a/6uItAggzLJknm4Sy841WyRVX9j0xdfyOtLoAISGRHzd6x1
         c2XiIGREWBWzk/JjXgTpwW5vfQh7YPz+UBK27Qcpme1LxWLGQOxOn+WerO6yIcS8uT2b
         gPhynR63FnG5Ev30Y135w39YSVJFd2+HOutoZWrsOjLb6/0y7XWoHh9p3q6qWCHEdf9d
         PQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUovrDb+YfFk3m+nS9n3JhLZ/8wh4KVz8otrFyjCpyPpvheq8C3ESJQ6y/gkqsuvBpEKu45kCHwe5PV+BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCpJ9jSnbxKXGS0ZjtM0wtGhKz0CKnFWmrJrHVaTqTYkJ2CCM
	M6EUFrn/Blj+xXJbrmmJubH06tDSrV2wkUcpRDRkQHmjLDsPA03J8Xb00bzmCpQHPd+mrYldH9x
	rU9uVE2kvH6fKMDDTpZwiT7mFTTIgUwbkccWaif0ZgzWmBJb1A7DqJc9BBMuejiNLCQ==
X-Gm-Gg: ASbGncv41BGE9XfRlKKnvueyVzzhgLJwWPAYYKewkQ60EpbdGiEsFe3/dlezpfBC4Eb
	ZSNnJ2IYp3hQy19bp4ify6v3myA3aaGjiSn1GXO9+rBbZsX2kvSJ2znZwCRWq/8Qwez9uZ2y63c
	Y5H2YIvZ6+KENpZ/Py+2WQfHO0F2Kd0EMKCrCfH2hz5ZJ8Vp6TEQLXR7+8lvMi02dLTX6vcwd5v
	UXzK1h50mGaL6Q8V68q9UOQdOe0Jr3zdmasRwFcl9NVh84ZC88TLNXOZEjHgsK8fmAOAdPyUW02
	PKFShZS+/CHwVBp8Co5F+wJng28K6Kpf4cpcy8iSUeGzRmMWkeEV4J1zwMpOz51WawCqa4KkAY0
	=
X-Received: by 2002:a05:6214:629:b0:7ee:aaf0:b759 with SMTP id 6a1803df08f44-87c20545ce6mr186916706d6.7.1760980088300;
        Mon, 20 Oct 2025 10:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2dJ1otsnjO4gPqjD5cms9cnStOkEvPQXBCTaBj9kaoCae+He0cJx4lWam6Mw/3/Lz8ib0iw==
X-Received: by 2002:a05:6214:629:b0:7ee:aaf0:b759 with SMTP id 6a1803df08f44-87c20545ce6mr186916106d6.7.1760980087735;
        Mon, 20 Oct 2025 10:08:07 -0700 (PDT)
Received: from localhost ([2607:f2c0:b0fc:be00:98f9:e204:8ae3:6483])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87d02d90b05sm54655476d6.63.2025.10.20.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:08:07 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:08:06 -0400
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in
 comments
Message-ID: <aPZsdplimqnRheb1@earendel>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20251019045620.2080-1-pcolberg@redhat.com>
 <DDN4FLSD09W9.30I0BJXFAU5YB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDN4FLSD09W9.30I0BJXFAU5YB@kernel.org>

On Mon, Oct 20, 2025 at 01:43:16PM +0200, Danilo Krummrich wrote:
> On Sun Oct 19, 2025 at 6:56 AM CEST, Peter Colberg wrote:
> > This patch series normalises the comments of the Rust PCI abstractions
> > to consistently refer to legacy as INTx interrupts and use the spelling
> > PCI BAR, as a way to familiarise myself with the Rust for Linux project.
> 
> That's great to hear! :)
> 
> Can you please rebase the two patches on driver-core-testing [1]?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/log/?h=driver-core-testing

Thanks Danilo, I have sent a v2 [2] rebased onto your "Rust PCI
housekeeping" patch series in driver-core-testing.

[2] https://lore.kernel.org/rust-for-linux/20251020170223.573769-1-pcolberg@redhat.com/

Peter


