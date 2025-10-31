Return-Path: <linux-kernel+bounces-880817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1485C26A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293281A6642F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C9272E5A;
	Fri, 31 Oct 2025 18:48:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1991E5718
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936535; cv=none; b=m3zDWKyQuC42NlbLjgozqUSvTsUlUCIgkZ7rpo+8I/buZzNwJIw3gVLwESB8LDFFpTpb97fIhKvxLfzLBI7Fk4CPehGWDTbFM0ZkYHENODhuFoFi4pUkQpUA8CcFbsrckubM2AFSNmBUx5wEcFsAJgTwM3cC/vYL3LbMq8qj208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936535; c=relaxed/simple;
	bh=XSy8fLxVzy5LU4VN6hk7ZOTfFNdVRvsBUK0B+D05vmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0sgh4Vd8Y2rui4sUbnnhliAZJPfALX43gs1h85wgjn0DqEYZFrsorK+/CyzM2EyrViC1Bgv3z7i+wVN9k01yF+e2rOyOj+/U9qX1a1IxKYLtnK//kLQ5uNU+ryuUuHE6PNFfuZ7wVqdQhsokMeFm0grbbAmXgdUMzyhvdR5STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86429C4CEE7;
	Fri, 31 Oct 2025 18:48:54 +0000 (UTC)
Date: Fri, 31 Oct 2025 18:48:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] mprotect() can't clear PROT_MTE
Message-ID: <aQUEk6a_3OWapRbE@arm.com>
References: <04ea9978-e6aa-4498-b899-76d56e19b084@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ea9978-e6aa-4498-b899-76d56e19b084@os.amperecomputing.com>

Hi Yang,

On Wed, Oct 29, 2025 at 03:41:17PM -0700, Yang Shi wrote:
> Our customers have usecase to untag memory w/o unmapping it, but mprotect
> can't do it. It seems like an intended behavior because I saw MTE doc
> explicitly says PROT_MTE flags can't be cleared by mprotect().
> But I don't see why mprotect() can't do it if I don't miss anything. So I'd
> like to know why it behaves in this way.

It would be interesting to know more about the use-case. At the time,
clearing PROT_MTE got in the way. The theory was that an allocator
controls the tags and the PROT_MTE property but if that range is used by
something like a JIT, toggling between PROT_WRITE and PROT_EXEC would
inadvertently clear PROT_MTE. I'm not sure whether this would happen in
practice though but it's ABI already, so we can't change it.

I'm happy to add support for this if there's a concrete use-case but it
will need to be gated by a prctl() flag to keep the current ABI. A
weirder approach would be to add a PROT_MTE_CLEAR flag (I think I prefer
the prctl).

-- 
Catalin

