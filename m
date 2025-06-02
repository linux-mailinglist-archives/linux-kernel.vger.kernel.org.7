Return-Path: <linux-kernel+bounces-670281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70972ACABDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDC317B2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252501E51E7;
	Mon,  2 Jun 2025 09:48:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3431E3DD0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857692; cv=none; b=BWpCodmQuxwlpajhHUdzDdKZz563wIRuk8LihKnNRExOyJEx/DihVWfRsPYaQ33bFCXkkYpwYHPmhL1voeRC8HiIOcUzx8yLLMKgZhazJspDyGz2w2E6tg0u0PUfurfeDhDujAL8GM3GmOhTJiMT+7VqDec8Zu2tUgO8GeKP/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857692; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTWScHZA0+KZ6FJY4+cEY61s/k8FrCYk22VMSnfxxBgnUO8w97QrdtdyTjGvj0l7Z55LxCnT7wTAiOW43LDPKX5Cyn+4P9sNfdgxP/2e7/X5M1bsUdz2/z+9+owft28DCu/XsvVifykMSSApucQl33R8fqxMhXaAyS/jBEnfnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8273F68C7B; Mon,  2 Jun 2025 11:48:04 +0200 (CEST)
Date: Mon, 2 Jun 2025 11:48:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, hch@lst.de, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Utilize designated initializers for the
 vmstat_text array
Message-ID: <20250602094804.GA1696@lst.de>
References: <20250602092351.3807465-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602092351.3807465-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


