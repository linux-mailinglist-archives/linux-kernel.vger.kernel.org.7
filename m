Return-Path: <linux-kernel+bounces-783084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034EB3292B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293DA17DA06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9325A63D;
	Sat, 23 Aug 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n1ot0HBE"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8B1624C0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959536; cv=none; b=X1Z/lJxlLQA9Dq/BhWmLxeHBpPto0X4LzHKA0ApsMUf46OyFqHnT+B7iQpkMFAT/WQ+dcODtr1/BcWxj4uA5kNLTqCK23ud0rouGAjw//1P4eZhW2nc8EJ0c9FC/gimvVMqvoNOrMlVdL2VwUkuelzU/9agCniGMDmgZne8YLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959536; c=relaxed/simple;
	bh=5CH9lXjTQZVNX3mX682b5U7dYvOQ+fFVPT7IU4f0eHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT1DFYkpYrlxk7lD7u8Ki1JRsR3kmkBtsnbFgwIlRSRYtbWoIwYfVqV03MLG/q1UwtX9E5glvAP6pw+9IIkiDashl49sqa7z58VcDutIvL66FA0WoWhrXbYoJPwAue+RWn/MFtowoGPnfTxwHwxG6Rohl0mOG8uw96wySbhuOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n1ot0HBE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e86f90d162so331382885a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755959533; x=1756564333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CH9lXjTQZVNX3mX682b5U7dYvOQ+fFVPT7IU4f0eHA=;
        b=n1ot0HBExF15JRPvCOtJItukkxwHwTURFfVrYEyDp6YbNBYH33RSxqb9nMHWSNDvV9
         qoD56gqqGQJBgt2Gr2OdA+zk/PgID+MivDysrdJ0f2XcewbACO+RMZlGtbfRYdAsMp48
         ECmJ6aqaMu8iFOsch2ljpgv/4svnZ3/JPn+wiBBXOd1VIMokMHAsul19wa0Z4ssfSl4g
         6p7pMeHM5S3N3sdxyCry1KJ8LZhBmEOJTkYX+Z6gPPEN5uyrmIpbH0ZUQaD+5UlJYczZ
         6ktinjt/6BF46vgx/kTatcyLEIr8voC/Vv1vUwOM0r/EDscpm6s3rEOAwTUEBpPQiRTF
         DtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755959533; x=1756564333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CH9lXjTQZVNX3mX682b5U7dYvOQ+fFVPT7IU4f0eHA=;
        b=IINB5rbZVcIBcUALbdRki2PXqZHsYMk5iWb359pNPO09K8wu3ZPBFplOu3R2c4maYg
         YAM89XMSaRpnIpYYQuZFyx1d9VoCo1q4YbyyvMKnrgBBv5cZPiTTE/iF5Cn2do7r8QL4
         OqP8dK9kIvLnGtWUFYJgeyGSUtTUYjApljLJqn8P7jIDippVDNWcJzNKBHGZ6Qx+H3J2
         6O0NgQVwllpw35sDvyZYorB9U8xowTkvIhVC6cOyuEa4zHsdnEKDBL8ypkOGuzV+NNy8
         WG/lyhltkaGJTS31f0xDQjnG6gx7TcSL2myXPQKw/SNBUiyOmULZ5RmxpqFe0SX1svkM
         RCrA==
X-Forwarded-Encrypted: i=1; AJvYcCXcP8IFouhKCuUrCF/vbnRggGS9ln/1z6v5ox4eEWTIKODzuLiYcMBmYIqaPrObk6kr7KSr1aRyd8MRUVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRclZW/s91GrEQdbnKEXZU/G+Q8uTRdV256gCYK7XPqPREKMn
	ZuCPLrbGHm+00XJxxgO/Xt5gPRUpyhEK2ukIMGqAASw9JZEq0RQtktrgirBYploRIFY=
X-Gm-Gg: ASbGnctgQxx9y77d967OrmGEN/0OcERxX1EDhimyaEXoakIdPYFQlZpwjlMNUpgb5KG
	5qzXkKNArzY5CyY4dTyYRbtnfg5zIiGNSH9dkUZRufTbwdYCGTPMhM7hCwzdi0V7vln7dUPI14Z
	TD8SwokFilGSJhixShNkv2l/LQwlVQhuX/Qv87WEf55lIGIwtstPyr2jexfVFEF2WNEUQn8JTL0
	85cI/GyWKtTvDEoyz2usJ794tghbyYvYtehdQLvxdDqeCGLL5ClDAh0aldMEJsnbtnenZBghZKP
	5FscVLhRcJlma8NE4aUsLbHHhIWSS91P6OJ/XIxbOYKLRvDILcga7tBrL87ZiAjcc8PKJjSd
X-Google-Smtp-Source: AGHT+IE/djxgc7wwTAcnCMpTeoyA5tWavDQqRByv2Dt0CCe5t45gjXLX0PKZfrUUEK/TsOhKJSkN9A==
X-Received: by 2002:a05:620a:459e:b0:7e7:fd49:b0c7 with SMTP id af79cd13be357-7ea091a22fdmr990347785a.7.1755959533345;
        Sat, 23 Aug 2025 07:32:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf4361caesm155711885a.70.2025.08.23.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 07:32:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uppHv-00000006Co3-3cJo;
	Sat, 23 Aug 2025 11:32:11 -0300
Date: Sat, 23 Aug 2025 11:32:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, akpm@linux-foundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	abdiel.janulgue@gmail.com, lyude@redhat.com, robin.murphy@arm.com,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction for
 sg_table
Message-ID: <20250823143211.GB1121521@ziepe.ca>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com>

On Sat, Aug 23, 2025 at 10:22:47PM +0900, Alexandre Courbot wrote:

> For reasons I am not completely clear about, the number of mapped
> segments on the device side can be smaller than the number of
> scatterlists provided by the sg_table. This is highlighted by the
> documentation for `dma_map_sg_attrs` [1] ("Returns the number of mapped
> entries (which can be less than nents) on success") and `sg_dma_address`
> [2] ("You should only work with the number of sg entries dma_map_sg
> returns, or alternatively stop on the first sg_dma_len(sg) which is 0.")

> So only calling `sg_next` until we reach the end of the list carries the
> risk that we iterate on more items than we should, with the extra ones
> having their length at 0

Correct, this is misusing the API, and I don't know if the lengths are
even guarenteed to be zero. To iterate the DMA list you must use the
length of the DMA list returned by dma_map_sg() and nothing else as
the stop condition.

To repeat again, the scatterlist data structure is "optimized" and
contains two completely different lists - the CPU list and the DMA
list. The DMA list is always <= the size of the CPU list.

For all purposes they are completely seperate things and we have a
unique set of iterators and accessors for the CPU vs DMA data.

Jason

