Return-Path: <linux-kernel+bounces-823331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64EB86243
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C26560778
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B0255E27;
	Thu, 18 Sep 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmVjXXQP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED2242D97
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214993; cv=none; b=DhRJTVezC4BJcqzS+aYVeLi+dtoDIRiAMKuY3S052UOnCx5NbeM5lVjhWWLWqmc+C+CzAPFStYUrkShFhlbuzsBUsTth6VL3hPU9d2X3+mB2uUm/9bKx1oLWD/nKU2cUPGwJzjUPofIMBzs6PDFDad/dw1Hwa3UEfJF8rZKKxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214993; c=relaxed/simple;
	bh=WqdXMGtL8w4zmU4S23uYUzbjQRhs7VBTRXB15Vt3dVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY7vKgYx2IMv0mrHu7MmE2XFj7Ny75kHzbdZt6Jxgg5LOfDNbW1RaY42xOvKLefbiwv6b3u4wp5uQ8dojubs/Ik3zTSIa1evhKIJrji1LHph66aXnOkOj42BKw6RMaI6vbjMyEX+Djxe0QHVqiFJkjAehppznyuMX3oI3OiD1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmVjXXQP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-265f460ae7bso9315ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758214992; x=1758819792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ym1RX9p3TOSmJKSmG5yfpw916lpqGnu+pp5TNhgvRs=;
        b=JmVjXXQPgMTCI//kri/rrED/j9uDHLqXDsaQa4cvxPU+IPCD2RnrA3xot/tPDAtGIn
         kzThFh2hRlvWu3SHHo6xdEwx9iCGDPkwkRNQ91914yJI9UZPVqAF66hAlkdRDo/fidHy
         8i2LKEboJxF4DNUAiO4QQu7IzNcUyFNyTNA1XnBCmm9tc/X8w1b1sAx6RmsvubxY8KRN
         3koZ1HAdCS2eYBblCF+pwILfAfB46270I4pR7pTEwSVZEAeWjM/y5KVVCXmD0VXHyE7K
         shU/pkZAQsOD650A+g8ycwAnEh+Ox1tehoJXqTJlniNEuCIP3/vaJRLbSQM/2AmNmSsS
         RSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214992; x=1758819792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ym1RX9p3TOSmJKSmG5yfpw916lpqGnu+pp5TNhgvRs=;
        b=S+yN4WL6gPo9Ih6Kxs9AyKGSluefwJbGCYmg8u+I97AGvon5ghy+j0JvH9ACzMiPBY
         AEXpRdTZM0AYUGOBkbA7bHZbSgRuPSNw5qMkKGQYptrdkxjhdmrJx2BiFrr6PUGv2K9N
         FtizoX0IjFNzvg3SJwR8h8l7oDtpcgL76fqG8zE067N5Tb3YJUKb3MYnCtDPdkXtDZKj
         4tW7H3xI6I90LRD+QHprHaxilek48+/uOWbN7T4I+AjE78SuFXvakyJdIzpMR7Sdebf1
         cgfPiUQS4yyT5A4hwpACzPDgFxh9sKEi1SCAiE8oYhfXrqYVkZsiLV1E/Y9pfIK26x8u
         NmkA==
X-Forwarded-Encrypted: i=1; AJvYcCUbN57fRgRury8Ub2x/7jUB1pBkAdCrCFZCYfE+xYXAIfTaB0Kdb4BASuiMhFzLWpHuizBIcp31xQDDWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy816zx6x3XLy1YeCAeMjFnrmSRh6x0GklqewTwIvvfHHRuMlu
	b2Zo1MwMyDRPU9EybbwFLz46sVlDPH2hdYaf5ugG5wDBHwOdKT9juiMbOWedMaDaPjdG9xIsieq
	zLjklyfNe
X-Gm-Gg: ASbGncugjgaSSC4hjpDm1sLJjVhchfyNNJTTIJKcxeBMMEaCMxOECbrSi2c3L8OCG7a
	r21Mctnrzrwe+zGj7acOvm9F2dIgCCh5WNLeOI6AMr7yyr2+6yrl1zuVeTmMVE6/yYEkTol/vA0
	LOIOkve85iO2sj/TNMx1Q8T8ckyUvr4NPh01ZRPIKxyC1SUhEtbvhftPI/oaw0WwwKUUe1pvKzO
	PaBLeKLkWRuLA8mGWWyqry/ZBLl2jWPb+nR+6tYVXgImzFn0E5Ya3uquIfAN9gdwwhcR9WmCmP/
	kq8qJE82By23STYQJHtUo8sR6cCi7cZHoYt4hMDs4XcHdHVyYBLEe+oGJhu5BleCR89eMkDs/iq
	W3170hPnXF45bGXK2tG6Sj+NW9DgcMWxtp5LnmLG4BFN9Ied2IGY3USdgX5Ih+Hk4A5EUKQgYkE
	uV0LihUIfd9A==
X-Google-Smtp-Source: AGHT+IFjuyi4QqLZ8qvMbqryrbOAzU3Sc3TkWOooDemgm6De8AipTLgjMlTSUGYxKpghu12Kv3bL8A==
X-Received: by 2002:a17:902:e74d:b0:269:7c50:85c8 with SMTP id d9443c01a7336-2697c5088camr7050725ad.2.1758214991379;
        Thu, 18 Sep 2025 10:03:11 -0700 (PDT)
Received: from google.com (163.180.16.34.bc.googleusercontent.com. [34.16.180.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980336511sm30783875ad.124.2025.09.18.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:03:10 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:03:06 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
Message-ID: <aMw7SmMz8CXOelix@google.com>
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
 <aMwxLQubVOuGZGLf@google.com>
 <aMw5b7aNxoULilmg@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw5b7aNxoULilmg@google.com>

On Thu, Sep 18, 2025 at 04:55:11PM +0000, Alice Ryhl wrote:
> On Thu, Sep 18, 2025 at 04:19:57PM +0000, Carlos Llamas wrote:
> > Hmm, is there anyway to keep a single binderfs.c implementation? In this
> > case we now have separate CONFIGs we could use for the file creation
> > callback? It would be nice to keep a single binderfs source file.
> 
> It could be nice, but it's pretty non-trivial to unify them. If we do
> that, it will have to be a follow-up, and the follow-up will modify C
> Binder too.
> 

Ok, that is fine then. I can look more into this part once it lands.

Feel free to add to you next version:

Acked-by: Carlos Llamas <cmllamas@google.com>

