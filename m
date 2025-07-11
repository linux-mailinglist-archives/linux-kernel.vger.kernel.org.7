Return-Path: <linux-kernel+bounces-727735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7BB01ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F093646BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F552E4981;
	Fri, 11 Jul 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIqyLd+F"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FD2E0939;
	Fri, 11 Jul 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243463; cv=none; b=Q0KkTFdMFrwDvcPGifLCcMbo21pFJLpPPfcMoG0zObBy/W4rsBRtVlkio9NFF7wksmenoVIZh9dy8oN3CbvUety40xzSbenxidlu8A2qM03is5LOyoslbtI+ldU1Js+zJsraFSrry+YYN/qgTxgCCF21KNIDGCmUNQOdJRz2Zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243463; c=relaxed/simple;
	bh=drETIl/jROPzXvjFx0KylH8snG1xWmuuvGKx2AVrXwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4Kr7yfFk8kFEeFDV9eeoBoucbB0EZY4EXlWxJCNtpDtyyxQ91F9ipBziwwcJplsvHuMa11w0tbnsauaiMJkOBSlGsJVqu8t9k1fptPZR8H7giBfihFb3WMNFIir8mk4T33OGUBZPwqpsoX05iRmDCuVJmMhz8GlpSt9/1xmogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIqyLd+F; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a77ffcb795so20357761cf.0;
        Fri, 11 Jul 2025 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752243460; x=1752848260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N++RXEHjieQM0ci6ZaOLIBjfnKPwlA53QT2R6OroCSc=;
        b=KIqyLd+F/DGMsgdInhWCcaRPe5Y9+E9lq0ay+w45rhWPnZrTUhzMk0QiEzHV387wxn
         IPobTzTg039mW/jyqD2K3X2JYAR2SxMLNBdFUpdFx5/ybLThJ9JpJcb1DK3lcCJw+vXY
         nT8lSNHzj7RnLmMtm6Df/559l4HlRDnXCKX/sGcBTLCnK7wsUEdJWxT1SQTi9EXidgmP
         HghwWJh7QXiBb++cP4dAc14Qa4r6A4G1pW/8/kHgbIXeMNqUAlUrcrA4VeHt2oE+NHdF
         jDMD+1YjS9BPiETLrJxgHY/hq1ty7NAHMP9QHgUbzeW1rO/q1hqQTdX8emTkwVagcz+D
         OWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752243460; x=1752848260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N++RXEHjieQM0ci6ZaOLIBjfnKPwlA53QT2R6OroCSc=;
        b=T8/g7rTTR3aKBdjq0OKhLVjwumuRn2bLLtNAAGn/S7whKkvr3dAfA6AnLT/vZW6qio
         Cg7A0DXwLVNP+2x5Y+siCSHTvvK9R1rPTuySg7ZKlveXc7UAiWu3ROG7AeSq9po+Y9Hb
         wbsh/uLyiaujC44y7xnOUY2/etngvMQYuJwuHFjJBG8cTjqWTryzbCjmMH2fOPFbQtBZ
         Py5YAfd+rJTkFxTlLg/crz9G/exYrrLL0PTMDhbG8tG5a9oeIfcY0P+i5y9YhD750MHR
         PfpNESYfGiW4j8JvYC1EevZqQeOizF6lKSCmixtfsSJ3P0aba6uIt2I9bK6oK6uXGSrn
         jH7w==
X-Forwarded-Encrypted: i=1; AJvYcCXOC0QjrVVxHOfUnqgld1VgRji+VokeG0pXV9f2nvpXtihcFHEvimn5rYHHSRMPm8Bc8/XpU6ypqZulLCw=@vger.kernel.org, AJvYcCXkiH/3tSpboGWbRA3eIm3j+XQJ52n7y2BkjE1cAe19wBVOZfL6LpoaBFnzK+YfhKSW69uQmyuywrTkvHRzAU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8LbctXUikqG8IjCISNQkdtGoGjBziUKSj4YoO9/F1uBe/f0g
	iaOV3CYl9xK6hvAiuyRA7pAxDIzTe7Cvmd5qWbZwWAZG1CyFaRhysVKP
X-Gm-Gg: ASbGnctardwrPwlVbtzO3FatTFlU4nQX5XIvTM2Dsd6aCIJAescz9/NozRFAmBie4gO
	QBzQggNkRyjZHG5anA1WdXPGoS5khch9HOmyTS1ET3Xopf63IxKUaq0d1TGZ8QLGcJ3gfejUykg
	BJDK2jmGl8mN8xVuCA57U5GK02613aPN2sTEr2s/gHSVrXG+lg/GGe8n6tm9svdAQ0DUsx60cn5
	0sl4+9x31RwlJFuO47CVX50LHjglKxGmz0xM+W7aWkClPOqL4DCJCfqCG3GhtVqgXlQqp5onGpi
	Gw1dcXaHHuP2xNtr+LoSzyZFj2rJSf0pMQiDYQMkqteBf4CdaUhXv+hMxZumFJYsQ8Fx/S7fgrs
	z/iRtCRTLLLD+XpsK+WxQCfoCK/l9b1TRgHxYZEiYDIoYGjuE+e7o4Es3tEmGAbD+NhpOiIQmfi
	mT+3uYPqkoaxuR
X-Google-Smtp-Source: AGHT+IHammHLjvAPSw5xRi4x+C3i99yFaWtFpkdnYjYGTd5oidZ1HIjVht49awOE5Bre9ZGo82z5mA==
X-Received: by 2002:a05:6214:4587:b0:702:d83a:7148 with SMTP id 6a1803df08f44-704a70161d8mr57818256d6.23.1752243460121;
        Fri, 11 Jul 2025 07:17:40 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde32bfcasm225548885a.65.2025.07.11.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:17:38 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id A4EA4F40066;
	Fri, 11 Jul 2025 10:17:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 10:17:37 -0400
X-ME-Sender: <xms:AR1xaLXCwOVWOEdpV4lGyqJk0D3LRKT2Q3nkLnzvhNTbxL7h4w0U6A>
    <xme:AR1xaPYML4v8uFO4TOWa3kkqFDLgWWxCBrazU1Ej9lwBncxgyMmyjNwVhencw2MeO
    jOvlJnsZwRhhV1q1A>
X-ME-Received: <xmr:AR1xaM7G-67UOtBAQFaFpCcx6mW7OuyljK5nZHyiaUXB9ted_U6M6gf-CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhh
    hlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghngh
    hshhgrnhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:AR1xaIzVtBXbniCSkA0lDSmvHdbamgOtT-pje6rpSUfS_9eZVAiluA>
    <xmx:AR1xaFoAUcwJe0xgkWJL633vk3pMnVuH0_imm4fEIfHTO-tMwRkmbA>
    <xmx:AR1xaC1AxfPQ2sJwzETsqnIP1dZqXXZZSYfpGXqLvzRxHUyqnwCO5A>
    <xmx:AR1xaGA_WW4pxsyhp51qlS3VajqA83J5rbtVjOLSr6KQciuvwjCmtw>
    <xmx:AR1xaLNBHbZBfDaR8vZKSYXCVOz5yJmF18MEij2h14oV1X5nZA88V4SD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 10:17:37 -0400 (EDT)
Date: Fri, 11 Jul 2025 07:17:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH v3] workqueue: rust: add delayed work items
Message-ID: <aHEdAPFNId2bgoKu@Mac.home>
References: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>
 <DB9A8OPZK3DZ.YVQPQQSD12MU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9A8OPZK3DZ.YVQPQQSD12MU@kernel.org>

[Cc Hamza]

On Fri, Jul 11, 2025 at 04:07:04PM +0200, Danilo Krummrich wrote:
> Hi Alice,
> 
> On Fri Jul 11, 2025 at 9:59 AM CEST, Alice Ryhl wrote:
> > This patch is being sent for use in the various Rust GPU drivers that
> > are under development. It provides the additional feature of work items
> > that are executed after a delay.
> 
> I thought I commented on this in a previous version already, but apparently I
> haven't (was it a different thread maybe?).
> 
> For drivers, we should also support 'scoped' work items and worqueues, where
> 'scoped' means limit the lifetime to the driver being bound to a device.
> 
> For better understanding, in C one would call this devm_alloc_workqueue(), which
> would guarantee that the workqueue is terminated on device unbind. Similar for
> individual work items on shared workqueues (such as the system ones), which
> would be canceled synchronously on driver unbind.

When using system workqueue, and at driver unbind time, you want to
cancel the driver works instead of flushing them (i.e. wait until they
get executed)? Canceling might be tricky (because currently we give away
the ownership of the work item), and I think Hamaz has been looking into
this as well, so add him.

But in general I agree scoped work is very useful.

Regards,
Boqun

> 
> This is very useful for drivers, since it allows to provide a &Device<Bound>
> within the work's callback, which allows drivers to access device resources
> safely and directly without additional overhead.

