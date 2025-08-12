Return-Path: <linux-kernel+bounces-763950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D95B21BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE717B6025
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B783246788;
	Tue, 12 Aug 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cvTLaKBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB912169AE6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971319; cv=none; b=pIjYJAfv5HhvgK1fyymqoEyxTrOSqwO7BmNqYnVjfy4yOkhpimNTUmcHOAx5djPayzd1LTgrYWSd3IvXoTuPy+pFLKeUo8ePOLvYCswfybFIGzD8TBrvou5G7g8zXj0rVfhwUYyUZVnCVueWnXF2frSZSd6OZwaXCeFIkKXei7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971319; c=relaxed/simple;
	bh=PFzKbM+2fBf16ElXHAHAbCarcxJp3vqRWsPHanph7lk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jGgYBf9L063e721TOI6HIvLy57A9LP9kFotzrb9DPRp6VV/UpGlgm8LCT8um8UK+YmfubUnDpoBrSnZcFHkD8akmPwonCY27w5CN7tt66Eaqr0pZGS2e1ZvbR2jqkh+YwfRkaFGYNBi5NP4fP66NjnInDzW44lYyvcEbmMaxkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cvTLaKBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA1C4CEF0;
	Tue, 12 Aug 2025 04:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754971319;
	bh=PFzKbM+2fBf16ElXHAHAbCarcxJp3vqRWsPHanph7lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cvTLaKBEBDVURD8sSrIpI1InFCjf5XX57tNgRWBiBq81fUfav7SU1vBYoUYYP0Eov
	 KK2mVLyQ0yPBOehKRbH+IKdeUxVocyl0ARLdMjlBVSTy9cWr3NpqW+T2Atvjz5/OXO
	 s+1sYraF9XHzEzw4esI25jmz4tsla1ihoMIGKKjM=
Date: Mon, 11 Aug 2025 21:01:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 0/3] mm/mremap: allow multi-VMA move for huge
 folio, find ineligible earlier
Message-Id: <20250811210158.3241454a858582a7600e62e6@linux-foundation.org>
In-Reply-To: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Aug 2025 12:11:20 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Subject: [PATCH 6.17 0/3] mm/mremap: allow multi-VMA move for huge folio, find ineligible earlier

I missed this series until just now, because the Subject: innovation
fooled me.

My pattern recognizer saw "[PATCH 6.17 ..." and said "that's an LTS
patch".  Because that's precisely what they do.  By the million.

I can't say I find this change valuable, really.

Now wondering which other patches I missed.

