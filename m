Return-Path: <linux-kernel+bounces-819080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E7B59B09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F06C4603E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F333EB1C;
	Tue, 16 Sep 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8BnDxmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCA21CA02
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034525; cv=none; b=XZywTIUsfywO1t/KRL6eCsb0YOLKRGMLYXl4n5WrKnUQAlRRy2Qrwmc0Q1zsievXuysnU+/P6r7v8XfoChCcY+qa7OTJ+Iio9snhrs27dIXvyIgk2XiaP4e02V33hZBupHsFmpyw9uTdz+6QRqQ1afiT61IbTJT8PLgfOTJVfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034525; c=relaxed/simple;
	bh=+h0GgC3LWghF6oM5gQKsTZ5ZQF+Tvm787123O9K2VnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S+KEt8+U7J2tDDJkS3aZ6m9V7isM+wEsDivz8Y7i4pm/hxToA5RgNiQN0w1ibFEd/k/ygB9auST06maMkMgKLacPAL1JbjRtvcRHBkFb0DISsGmpD+HGXPiQJQWSWXZ14cLakwBxvs3RL7sxi+Yo0DhiRLqJpZ8qjX/Pfol26Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8BnDxmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12B7C4CEEB;
	Tue, 16 Sep 2025 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034524;
	bh=+h0GgC3LWghF6oM5gQKsTZ5ZQF+Tvm787123O9K2VnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F8BnDxmdN1uLoWQamCkXCpbCbGajjH+Z+Eg8tkf1UcJKxqTTVmOev//JQa5hWNpwQ
	 i8HcFmF6APK2Li5miaU/G5IkGv+kmRhTGx+ussnfLk7X83mGUzB2bwKyvgUGg8cW/q
	 baII0v+rlbsJ2MwA1IYCgdvx+L6RRPiwlvJHlIts93SEPz8bytiW7lMKzjLSVjDuXW
	 PMWCX2Iv1vzFPsDTHZ+b135cCz/pXlvVTtbp8b1O2yccMTIyYK9VrmtEQ0aRldQv69
	 77xlzKdpRw3QPhyd18JUFu2d1oKDWMhgxpWtzgxjeSQYpXtFFeYOGSYfhjyMjKqLdu
	 50PtUC1KkbM3w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Changyuan Lyu <changyuanl@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Chris Li
 <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <aMl2H3BLpH3xFCOw@kernel.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMl2H3BLpH3xFCOw@kernel.org>
Date: Tue, 16 Sep 2025 16:55:21 +0200
Message-ID: <mafs0h5x2h2g6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025, Mike Rapoport wrote:

> On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> When restoring a folio using kho_restore_folio(), no sanity checks are
>> done to make sure the folio actually came from a kexec handover. The
>> caller is trusted to pass in the right address. If the caller has a bug
>> and passes in a wrong address, an in-use folio might be "restored" and
>> returned, causing all sorts of memory corruption.
>> 
>> Harden the folio restore logic by stashing in a magic number in
>> page->private along with the folio order. If the magic number does not
>> match, the folio won't be touched. page->private is an unsigned long.
>> The union kho_page_info splits it into two parts, with one holding the
>> order and the other holding the magic number.
>
> I think the sanity checks belongs to the core kho_restore_page() function
> and kho_restore_folio() should be a thin wrapper for that, at least until
> we'd need to allocate struct folio there.

Hmm, okay. I can do that for the next version.

-- 
Regards,
Pratyush Yadav

