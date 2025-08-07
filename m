Return-Path: <linux-kernel+bounces-759315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97FB1DBF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BED627801
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CA270571;
	Thu,  7 Aug 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGwS/KMi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09E186A;
	Thu,  7 Aug 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585440; cv=none; b=pKwJKAmSSse0vO88dAziUqSNGjnq1jV89rIeViHC+d/lKeVx40xIoEvKPyfORJVDagAHrQS6ZKElWhM6aaJSo/65SIctf2yEQo3qLHrFc1Qgrsk2GfjB+EhWF/a3GZ9c449aaHRg4FXLtRVvQ56bAuSbTQLqILQr6IT9bXPIhOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585440; c=relaxed/simple;
	bh=Tcehrj422Dz/EQcSNUSZg7gsfb0vJ8SAd8MQ/B2zkxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHn92pBpBZAe/wD8QieEJOlHAMdehEejg3/6pmpi/H3b0hJ+smqxjHvMjp5rUcnFAKBV3I8lyqwKkklLZWLJUuMLxdlUfWTm3gRWVAty1dxzrHx+egHW7G/Ga7OzMlMqEQudYQcxGw7IV/mEDP2d26mGOJWNNjep0OPhuA85tL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGwS/KMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4832BC4CEEB;
	Thu,  7 Aug 2025 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754585440;
	bh=Tcehrj422Dz/EQcSNUSZg7gsfb0vJ8SAd8MQ/B2zkxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGwS/KMi7R9jL0LYkH1LCvWMRqQTX2ZCXn4MwEOGee1Yxl5JJTsrmrL3wQ+98E4KP
	 F4iteIvihDPwcYUgOqqABPXxOnf+A+iH/6eE1bKm0bGSUFkpsQjNXxgrg4/Ctq+Mvu
	 il6hOFBj0dbA4jAB8szg4VFOItBIS6qPQWNEiNUNbO0kCgj3eW0B8jWKEtKcJTEzoV
	 vM9cjxWPbUEEFWpaqs8QOX5iOYouY16qdFKx2bm7u6i1Gw3g3DUZdiLGaKdNamWOLG
	 YcgPHN6hz9dGfIyc5Wg0fbcXd/Glg5NAi+rqpGbSvhNfJLIW7gHJs82RG7SgLYQrJS
	 WHw7ajwmIXrvA==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu,  7 Aug 2025 09:50:37 -0700
Message-Id: <20250807165037.53199-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2fa2f288-bb82-4a9b-8dec-3a4c768fb970@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 7 Aug 2025 07:55:27 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 07.08.25 01:48, Shakeel Butt wrote:
> > On Wed, Aug 06, 2025 at 10:14:39PM +0200, David Hildenbrand wrote:
> >>
> >> But yeah, whether these "as is" pages are movable or not is a good question
> >> as well -- in particular when zsmalloc supports page migration and the "as
> >> is" pages would not.
> > 
> > By "as is" page, do you mean the page which the reclaim code is trying
> > to reclaim or the page within zsmalloc on which the content of original
> > pages are copied as is?
> 
> I mean whatever the "dst" is here.
> 
> +	if (zswap_save_as_is(comp_ret, dlen, page)) {
> +		comp_ret = 0;
> +		dlen = PAGE_SIZE;
> +		memcpy_from_page(dst, page, 0, dlen);
> 
> IIUC SJ correctly, in case of zsmalloc "dst" is just the same page that 
> would have stored encrypted data.

You correctly understood me.

> 
> If that is the case, nothing should change, really.
> 
> Thanks for clarifying, all!

Thank you for asking this important question, too, David! :)


Thanks,
SJ

[...]

