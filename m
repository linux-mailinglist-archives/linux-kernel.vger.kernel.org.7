Return-Path: <linux-kernel+bounces-829212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B95B96880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C620118A5563
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ABC1EB5DB;
	Tue, 23 Sep 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCS63SJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D415ECCC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640532; cv=none; b=cJC4Jry8w+pyjW3Ri0LfBO8/qhM0Tvy6YeyVXy37d/Mto0XQVDj0B1J7SjGvoxQJlSbA0EePDkZ25HDUhWMQyUNTJmhJ1L1P7UV+wuVRDS60bWK7tO/Rzr9U5MWbDNjt/nO3I5F1nTOtzyZD+MRrdK828dijpn3Klua5GsWesk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640532; c=relaxed/simple;
	bh=QSh2pUh6qCemOJPEa86ZyI4Hu1DhQf+P0kZsqsg4+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tee3h/7t5Hf06bmTzYrA8eXWjQlhwh1tcXoS0bGVciFXyAQ00+IxQW12bzQrLn2qzYJ1JUHmwBTMBRhjo9MdYjU+dCBlwcMe55TFoMt5tWD8JGIhJiVdM6XyQxExq7O/JJtjggqkWQd/7Txp/bmi+Owp5BPXL2JmZLwAfpr/Kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCS63SJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E5C113CF;
	Tue, 23 Sep 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640532;
	bh=QSh2pUh6qCemOJPEa86ZyI4Hu1DhQf+P0kZsqsg4+E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCS63SJazASXNzRkrOlvTGvPwSZ4WgZ4Qozjuk44A1ZMVyjS0EA1uFzwstBZZDXea
	 l5IIB7sji6k5wkq/1XTOkY/qZu0lZnCovc/1WE/jn9bmf7kV9Eotq4RCur8J1+TBkL
	 tKpECpE77BlZiUV5YGkxEbwMnvvAe9XpHRdfF4p+lNgj7BECehCgePiQ1NKj+sTACo
	 zXSGGTcYXAxT5CZslc5KbvMMpTBqT3eH99b6uH2b34TPQpCXaTenBy97z7eoMyQAPJ
	 TGAHG9cQT6Ax32fZIxTreXjORfK/AkvmZlwNTsd5RySBWrzFD3D2/nrUDP2mv/KPvp
	 iSTQWPYUau9PA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EB5AF4007D;
	Tue, 23 Sep 2025 11:15:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 23 Sep 2025 11:15:30 -0400
X-ME-Sender: <xms:krnSaEgNOrFhUKsirMpjz4wKIcsX3MsPAoN70VHGHEQu1h9JbOJEWQ>
    <xme:krnSaKoSppnR107HP7WHmMcqfbZf61qlgw8lSq1JybzbjM3R7u9EjUch-8zvRcJ5j
    j839AIKrZflR0thC3vKrehx8tjR4j_WL5xKMvB5XKOKn6d1_t8OeA>
X-ME-Received: <xmr:krnSaDdAaxBVhjMOWueRHBXq92Su4eeP9xreY48DUyk1Reuvespzfq9W54sZyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhieekteelledugefhffekfffgjedtveevgffgjeeffeegvdekteetudeggefgkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilh
    hlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:krnSaNeNNxBH9Co-ub2i2lOO_WELsoMFk5c2VBgcZ-0aXWlp4o5ErA>
    <xmx:krnSaJdGMg8WL80tZJS-67eBovd1w2IScYAdzYiOjVMkdxOpe_GPPg>
    <xmx:krnSaDo5l4z-cBqoDmakAfWPzYxHAWx3qxoNQK9VDtpaF0gxq6RThQ>
    <xmx:krnSaJzEI9JVYkyKWNz2S8lQ3OYEHVSt8sLQCWzgU9dGryfdSEdjQA>
    <xmx:krnSaJf6A-GF8T4k63smQCJksDwqgfUPzQiHl8SsO6l-LaZ1guBrrSfI>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 11:15:29 -0400 (EDT)
Date: Tue, 23 Sep 2025 16:15:27 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/6] mm/page_vma_mapped: Track if the page is mapped
 across page table boundary
Message-ID: <abawjykg7qeorfisqsvvban3qmygi4d3pggoeas3hrld5gqihe@an33ftrczceg>
References: <20250923110711.690639-1-kirill@shutemov.name>
 <20250923110711.690639-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923110711.690639-2-kirill@shutemov.name>

On Tue, Sep 23, 2025 at 12:07:06PM +0100, Kiryl Shutsemau wrote:
> +#define PVMW_PGTABLE_CROSSSED	(1 << 16)

I managed to spell CROSSED with three 'S' all over the patchset :-]

I don't want to spam with new revision.

The fixed version is here:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git large_folio_mlock

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

