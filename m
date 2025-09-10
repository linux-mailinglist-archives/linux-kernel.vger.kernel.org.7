Return-Path: <linux-kernel+bounces-810466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC3B51B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F15C7BA2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE026C3AE;
	Wed, 10 Sep 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzrLkGbN"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5D242927
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516784; cv=none; b=W4hWui9A4TMwGAFU9MOrXhQpOwXp8AHkUhHmZMpgSsGAN1CGGg5yg4a8pbrwEJF54r7Tl4oiv4C1ZaeEx93q+6+DtOJJ+fx5Fezt87dK+nCb7G2j9/hw8Afk4m3H55C1Um3PDxJ8jKfI+07NDtaOgSJmaczMLgy4al7DUbJyVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516784; c=relaxed/simple;
	bh=WRj/k0r2xtwk/yI5lZIzerS6VoumZFaocGJzFvR3CG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0RHwODTJdnUnJO99Ye4vbiUhjcG0UsaKnP+1MVp7nAJxIU4x1aSWEbGuYCjdkPvnQXVHu34tu/OpKIXs/btf5WUFMp4x6OK74PECnqTmdUl1dSQz8TawcpsrbAo11Mm5jpSOq52l5dCGAjWCFIK3t3Ecz2CTDb7bOejPOamQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzrLkGbN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b5f7fe502dso23139581cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757516781; x=1758121581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkuRyXmfbcMHv2DSfTU9nR1jehGN19h5trO6Cne7aXk=;
        b=ZzrLkGbNSk755WFja+5rH+8jP1OwKKgj+L7hR8AKSzScBV61E9eX7wYdl+WF9Mke1m
         Fc+t2ovSd0CwonCK3GaB5lRoSR+WKkCfk8xldAcAbEVX6NsNaL3LTZTUGsZHt9Eb2YQw
         yDXA4Hfa0ubwxvjz6r5P1/VwO7bZaEhnCJwXVgC5wh5IkHhxRL9xVs0jntYCYwoTf5IG
         o7YsNK7ub6OSofmb7fD3HmICswfJiEhDAN+Z+Ljn7eUvUR5FAgZHp5WAB3uI3rN5yXgM
         /0+81IitrqA74jLYLG0EO/9KhrTfHLpHe8WfUM8JFi9Fa4Mp0zp88bRAvD41Hv/OSuIL
         4Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516781; x=1758121581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkuRyXmfbcMHv2DSfTU9nR1jehGN19h5trO6Cne7aXk=;
        b=KGUZA//uW8tW/egLG1R6cfYrebhkR7IBt0OWaeQV4/vk+ewkrTS8/1Or1HR4t3FprA
         opUguFDK65YI7FH0XZ7xJVuJcveXRkylG/cjwe52gDlquC+5Yw7743GAD8PYnuo2S7cl
         V0Hbzb3IRx+TQMSPB76ER8+G8+Sstm2zAgeeMxDtvo9edKvrB4i6CP0veFYr+bNt5nG1
         xif3ALHJOEV1iWbeCNbG+yrtXRvr1GaYTDXHvS+AZ6azlNfgNUItMaGU/UeXB8zRJXeG
         AitMlvzbQrJ4H7rS8cB/OiTjmKsauGLDpVCAqDlT9nPPZz/N0OE0+qqBswCCPY1KDTUQ
         HRnA==
X-Forwarded-Encrypted: i=1; AJvYcCVToPu1/DQVgitJAaq6HxWBw0inqr7V7UA/QIZXf8erJFJa1MrLkqss7BDY2UFlbq7jHQLyEcbDxNp3TIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhs43gMincP86sxrt6b81wF4+lxC3P6f+jaBtbG/hdO8MML41K
	G9Pxvcg3TP1V3xgvd0GwkA89ewK0ZfsZfcM0aff8KGH0/Z+m3dn03EEM
X-Gm-Gg: ASbGncuBdfpB2//1JwASS2/ke06o2YhtGx+tkvKwZu/9ARnpnlwyeo6X2lRyU2a/LQ6
	39aqTJIovw4xMmkVFKLH09RNHmExvEQ7GT++MAgyE2XvLibiT1SoJ/WtdiEK+W0JDcTMz/aGRzH
	SBOj47/g8bCbzHvnOWc25wMdNdsQS8s3vvyxxdwxFXkKvvCwuwUS9LIXpQlpyFGw9gcpWfDGf7D
	UL6bGhUxBfeZPKtyQR4v0mFUs+lpP47O6Ys+4pGKNRsVZRRF2iXKh6Q2s6gRVhCIRvJ6SWcdD2w
	6BPXRW++FMFA/XTMZhIXfm9K0LQrFgtolLpn6lT3LDMLXaU0hSkdZhMRxeaFkAYotL0fdG7V/ct
	T/+uPrs9qJYq0/Bkw8q/8Lk+7lYLxUQW8QBUswX2b+6O4kp6OqyOm9tnUg8J4S8mMb3rhBt1fwt
	2B67tDdlEvftvIGrQcqUS98dc=
X-Google-Smtp-Source: AGHT+IGV730dPkH+7LPV2ZmENlvah0J2LDWVfeVyU3QtTkU3pVSmsCeZ/SDh7VcDX1L/gE2E8Wx/Mw==
X-Received: by 2002:a05:622a:5444:b0:4b3:c78:fc18 with SMTP id d75a77b69052e-4b603776dedmr98515491cf.68.1757516780637;
        Wed, 10 Sep 2025 08:06:20 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b599c4331sm307244185a.26.2025.09.10.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:06:20 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D026F40068;
	Wed, 10 Sep 2025 11:06:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 11:06:19 -0400
X-ME-Sender: <xms:65PBaAe_lUZfbyXcyHf1mthf5kq-L9xmUHS8n9OtE6YO4xzFYEN1tQ>
    <xme:65PBaAsoQeOPK1s884KNimoLD2yhwMwqIiSSRRGlhVLGMZFccB8n5xZ4cPMgpUgbC
    37v-Wm5Pkm9poCmPw>
X-ME-Received: <xmr:65PBaNAt-l4LToBGUFm6m6q5hdvKWpTqHjoQkPZeRAd86Uh_OX3qqsWz6rRBNBjUbYD2i3zh_dp4ACPfk5xSdFZEsL4UgzSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtth
    hopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegr
    rdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhssh
    esuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:65PBaAH16bORS4q37pnLds3DfUUBzlVGn-Pt3fvYto7VJvQoHMMSdw>
    <xmx:65PBaFu3iMhSF_sd2as6faYW2plPJt29UweisNI06gLQE5WIPPAIbw>
    <xmx:65PBaOlkkWu1_rVjx7sXNNNNs2HD5bNmGq9-P9AJ8tWUKSEy_FPo5w>
    <xmx:65PBaANikgn1PRJTlXAFqhkGv79Ja_NXr6ICMfQHaLTy-zD2f_1Q4Q>
    <xmx:65PBaCwN7TiYe2N5IxvtRfb_zC04VSLMVczKIFFj30SuybJgPqrsO9If>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:06:19 -0400 (EDT)
Date: Wed, 10 Sep 2025 08:06:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
Message-ID: <aMGT6h5yIcpR3mCg@tardis-2.local>
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com>
 <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>
 <aMGE64_J5R8U_rk5@tardis-2.local>
 <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org>

On Wed, Sep 10, 2025 at 04:59:11PM +0200, Benno Lossin wrote:
> On Wed Sep 10, 2025 at 4:02 PM CEST, Boqun Feng wrote:
> > On Wed, Sep 10, 2025 at 02:19:00PM +0200, Benno Lossin wrote:
> >> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
> >> > On Wed, Sep 10, 2025 at 12:36 PM Benno Lossin <lossin@kernel.org> wrote:
> >> >>
> >> >> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
> >> >> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
> >> >> >> Assigning a field a value in an initializer macro can be marked with the
> >> >> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
> >> >> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
> >> >> >> structurally pinned or `&mut T` otherwise (where `T` is the type of the
> >> >> >> field).
> >> >> >>
> >> >> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >> >> >
> >> >> > Is there a reason we can't apply this to all fields and avoid the
> >> >> > attribute?
> >> >>
> >> >> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
> >> >> might be surprising too, but I'm also happy with no attribute.
> >> >>
> >> >> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
> >> >
> >> > IMO the ideal is if it works without an attribute. Perhaps trying that
> >> > in the kernel is a reasonable experiment to find out whether that's
> >> > reasonable to do for the general language feature?
> >> 
> >> @Boqun what is your opinion on this?
> >> 
> >
> > If we plan to make the in-place initializer language feature behave
> > similar, as I asked here [1], then dropping `#[bind]` seems good to me.
> 
> I don't think we can promise how that language feature is going to look
> like. It will definitely support accessing already initialized fields,
> but in what form remains to be seen.
> 

Sure, but in kernel we are able to stay the same as whatever the
language feature will be like, right?

In other words, as long as we propose the same thing to the language
feature and keep kernel code and language feature synced (presumbly
there could be some more discussion on the syntax when presented to Rust
commmunity), then I'm think it's fine.

Thanks!

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > [1]: https://lore.kernel.org/rust-for-linux/aLshd0_C-1rh3FAg@tardis-2.local/
> >
> > Thanks!
> >
> > Regards,
> > Boqun
> >
> >> I'm open to take v2 or v1, whatever you guys prefer.
> >> 
> >> ---
> >> Cheers,
> >> Benno
> 

