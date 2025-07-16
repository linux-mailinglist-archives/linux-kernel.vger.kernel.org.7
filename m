Return-Path: <linux-kernel+bounces-733867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446AB079FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CBD5810E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2621C19E;
	Wed, 16 Jul 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZORLPbA"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785929B8FE;
	Wed, 16 Jul 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680131; cv=none; b=spgaeEOPsE/VFs1mktOshVSci+z9gZR3zyDYBEiDmaMKzUTQ/ORmyke4mg/iDQLeAQSVnVMzvc6ZB1mBhIObNnapU/U0mM+XXCFjQPLJxNtPuYvm8etWFoREX5QJjeQ48S4ekaLfFonspnFFs3HPV+/4fsefcpaFJrLPhnUW4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680131; c=relaxed/simple;
	bh=cXmq5/AtROeA8Pn6qLC9YpfOIq4tZnkAEGzQmx/6E6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeiSTtYbs8ROQmvhZGO2D40TlYMQx0tSTZ0VL5Ofuo5BipCQ/dVbbJq2p3HRY7M/EK0cdpVtVvn/rlHvBKDvXgaAsri0JGIfrYBxzD2zJenwoxTxC205cHKLMFPpMzDj3WL2Tc0WBOOFHgIIwB2f4+twdXh3GKclLgsRBTRecXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZORLPbA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab60e97cf8so405051cf.0;
        Wed, 16 Jul 2025 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680129; x=1753284929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y80EpOl5xi6irCZLOI1hIGlhQgSnmXp79NlPigyetaU=;
        b=NZORLPbACaFb6Y5qRElYuqx6yZ1sZL9iOb3YtxFCSkfdy/O1sorw68GNKc1Juv0ElE
         RV+qfh/6/kv0xy3rAd04yh1DlyvKC7w6oRMUsKStCdgsOdP/Zg0/Jkn2tgvEB2v6I1e+
         bpPhx9donKaDJDCa8E7aA4w6WpNpm/JDtt4JJPQuyvJyiRRtoL8Pmvvd/W3vXQSQPE6o
         7j6f0L4ciGDQsV+QYWWPokoBVqfwGLebiCyuwAh/I6hxr9UIiwDN7Y9GOts64Ebe1a/+
         Qc/MedKkEfp8tFlt6O+dkm1YX6wmnQzAGHm7VKkMU7Z1xZ7FBRMgpO5Ny8qUwL2ihMmC
         ZChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680129; x=1753284929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y80EpOl5xi6irCZLOI1hIGlhQgSnmXp79NlPigyetaU=;
        b=FyLJLJfO+a0wVNaff+3VWnvdotXKoA3R18lvqDwlLTXAabo97vmgcwQtHHlzWA2JuV
         v1wP5ViVxnqmA95Vzh5C44nXoXZNLZz08NOxYpBhqYWbPYJwPJB67kYMwTDc/kn74RfS
         F7IvmK97aRrf18WAzBKH48p2N9QXajIIYnZQUXYgpaxUQw8s5JITujYbzhFOpqhRRjcb
         PXceXpD27TkvTC+djJK5Coid8BiF8Gg6zFngLODBG+/0BYMeBNuwys6Nfn0lxVYfOYW6
         MxRRokpD3uFiI3tYINjN43++wJdD2tVsliSX6xv0I574KV8TwmPsp3A2h2k+b3/MPThb
         Rs3A==
X-Forwarded-Encrypted: i=1; AJvYcCUIw0ra0S0S4wn+heketcoVVK7594ch+7+lzL7pm62Cgnvii/QrqXC/eO1aQEgVAeI0GSlWQ8VcBvobJpHu51M=@vger.kernel.org, AJvYcCVvKSK3AuP1/adgLsAvpPnpp8ZzFIhbPXwruoKUoZE56fcDAoSn0XYEKeae0cAamW+ux6Bk9aqmh4DAXEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49K53wPbKu8O6gW/LfCPF8dDpZ5QSzyKnvLlT7ndVFHfcFVoB
	6R8wk9Kxs+ZqR4/haw14y7zQY7MpPryrcMdyp3B2bQ5pdlTJNFly+FdV
X-Gm-Gg: ASbGncuYa2L3zbLIcOVh61ii8QflYKKD3yFJOTrJv/Y56txKl+D36qa64d0+cif5A7h
	lRtq1/7F2TWc0nsY86vV4swxJgdTgVpJAyfSpTWHSS1qq+vGk02CHwY/dYKuMB+18/WUZcE3dTt
	yrou6e6AfDiSxKZ2b6aVM/GatKXI9pI1h3tDunqp2r+JZTiAxYiOKq8dsD4torQu/56tAXk9Cdg
	TtQd29mivptMcHa+tQ4s8zqD9XP+8crMTmaGgzMyHgQKzYYF2VSa8n/7Q6cdy1zIW4ww8JmldDS
	DJiMLV9O1wP4gOiaFPQITt0AkWe5XmKPWAgw64beudrPtRQTEjqZqc6ZN1r2n2uZbD/+Q51JXo3
	27+amGQ7XICjKcEEjXuqdTVmowcdkEksxBjw2jPBN/kvoL+TL+ca7Q5acaynHGU7YAQCWE4wklD
	WJJ0qgU91RKIBeZ7zoqu3rPfU=
X-Google-Smtp-Source: AGHT+IH9q3icJfvLBLkV9kbcK1h5N5XC/aPnicG4W2NRtLwYvPY24z5z3T/FHFOz0CxquUUyKcsehA==
X-Received: by 2002:a05:622a:4894:b0:4ab:67fd:e323 with SMTP id d75a77b69052e-4ab93dd739fmr35321161cf.44.1752680128367;
        Wed, 16 Jul 2025 08:35:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab82242a82sm19477561cf.35.2025.07.16.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:35:28 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 731E1F40067;
	Wed, 16 Jul 2025 11:35:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Jul 2025 11:35:27 -0400
X-ME-Sender: <xms:v8Z3aNce6BN84gUVs6L0lostUiSrjrjVt_lrxYXSX8IC0qbIXE_TdA>
    <xme:v8Z3aMvnn6ilythR5hZYZEMSK7GqYgMOa-1JScK0LgeW9y6w8cAzoiHAuIiFHOrCc
    uVtbX-_RaOi4XZH-w>
X-ME-Received: <xmr:v8Z3aELsH1JbqIuYxE-WxorxyUmbFH5htqKZqDDpwbBGU1s0OnQ6KRcQOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghvhihmih
    httghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:v8Z3aOaWcrvaLqFPOfbC_qb46vhiE5vNOpP4G5lFqOwdCCTbpjWjBA>
    <xmx:v8Z3aKJ_jfAP3AQpDtw-ORO5FbiFaNwDRJ0ckqlA9P5RjLlf1sM_hg>
    <xmx:v8Z3aHoD4vxYVx2cf11RfJM4hWAJB46oaoHEm2Zu2HQAx-K112NN1Q>
    <xmx:v8Z3aDCu7R0wusuZgpTY0yGzGRp2BD9Tlq-fNt_mzg-0HxDK7welOg>
    <xmx:v8Z3aNcJqRixfSwFa26WT2mJBv-2AnOXCsnow487Mmg6E46opHHI8tBj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:35:26 -0400 (EDT)
Date: Wed, 16 Jul 2025 08:35:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
Message-ID: <aHfGvmq3zFWL6Hbe@Mac.home>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
 <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
 <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>

On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
[...]
> >> 
> >> Sure we can do some experimentation, but I don't think we should put
> >> unsafe abstractions upstream that we intend to replace with a safe
> >> abstraction later. Otherwise people are going to depend on it and it's
> >
> > I doubt we can replace the unsafe abstraction with a safe one, if users
> > really care the performance then they would really need to use some
> > unsafe API to build their safe abstraction.
> 
> That sounds pretty pessimistic, why do you think that?
> 

I could ask you the similar, you barely know the implementation and
usage the percpu, why do you think it's possible? ;-)

Regards,
Boqun

