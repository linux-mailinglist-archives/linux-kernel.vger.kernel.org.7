Return-Path: <linux-kernel+bounces-879410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DDEC230AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0458E34B38E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1693081A3;
	Fri, 31 Oct 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br1+UGyd"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A018DF59
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878499; cv=none; b=G1Ftxs0AbMTOVDEpPnvYdm5XLoCcmlUjp8iLhQwf6iL0d8ipjnTwgatZP/Y+oqb/yIcJzIchOcDJtTdhxBEQOlRh5I4EAV3aGcTCO4Ahm0yJgmjCSTulv5RRq3GoaATzBVUXMoLBtiYY1c1XOa9zAVAlvQrq2n9MQTOtardkhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878499; c=relaxed/simple;
	bh=2u+ToT4fF4FadWMbfDJ+MqfqCPPK4iSxquVlDoG35QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMk+fFx2VthyPZtraXiDBbw+Vj/hy2KF32z3n+8LFbPxrx4FGp96a1bu/OubsS2DjV/G3XEm55yqVFMU+fjZL1ZT/qq3J/H9bRLczFGEXclOGcAMh52TjnZBTIwnfsBouCAxK+j+p0ZEwqYc5+bGr78qWjfOfh28WC9uv3gwDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br1+UGyd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso311814466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761878496; x=1762483296; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8K4f+qBwafVznhIbPVk3RvAHNaTQKFSCyEiTyB6/Js=;
        b=br1+UGydjZeR7RfirmrzEThgo/pYw2KNaNfuHtaOQY9DnKNwFLgs9cbBMQ52mcUAtI
         3Is+2LsBi3lWXGGYC4hNchKp0SP4BOF3hcvd5ig6DMBO+grmfHj1c1E2JOyg6lG1PxW5
         Wz4wiZLQP2K/RvIY6l15eaFLoWnpb2nDmUmzrtwF4Ab2LxJWDLzl4MgesD3tcWuHsKDi
         wNyf37VfW9cL/OZqTZKzKNFlQ53xamlJb9AziWmz2WSb2K9FpZOdh4vbQbpRCGeRBeXu
         gXF0nz5B/Ed7BP2HBCAMd2Wldr5qK5ZaQhJ4m+XD9/ARYkrbzqj6TlHvfLHcDvC54Lu3
         x6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878496; x=1762483296;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8K4f+qBwafVznhIbPVk3RvAHNaTQKFSCyEiTyB6/Js=;
        b=mqhfy7GrycCTs847HTo3Jc+DqU8NcSnmuuZtQxsuk8qLqBbSYTOrALqYHTbIH3O/pl
         Xv/wOYj910vumBoaz5WAW04zK7N8rXDeMDHdhUWC0Re5t/K656YG4cQfS4Wt98ecVcxh
         F2aYof9EW4/wWJGb5r/YmFPgoGYVVnteU+25dhaCXFKNZXoee5s8/Bgjm8c9Qw9gVFiz
         6t3KUL8HAg7fDCx51HKgj5V4qk5rDTCDw/uDHzXIMS+4TlcGQ/SjamW7MBzT9I2Y/ulk
         BZnBUCnjbXV7yp9VGOUpdYYKJhupX/KJP2DkfTYATxzpmS+iq9JpiaQEdwYVpHO1ffcb
         NRHg==
X-Forwarded-Encrypted: i=1; AJvYcCWNnoQBd3ZXyEcr2p+SgIsao24rUd8DYiDrf/A++zT13fnRZg0vWrORL5LiXA9cExJrsiY/jDXAlE1aVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRvyOy0S9PrClGJBa/m0d63JBa+/ScELGa1M1a1UVcBUsfFPB
	L8arpIlFYiZtHAU+6P9HGWVAixfaCCKyjr2VfECwRvFkstnkYz9hrzI6
X-Gm-Gg: ASbGncsP069FYlLBC0j1OY/owYiyE4NwJC9cMbv7x4OMuf5lb+So6sVo770XhwCfdLG
	NYY334ctwkl9uP8ABvOiifqCP8/egfMOvkIYM4gmEtwA5siiY5MJi2s8AA+Ee6/oRTUD0FgVzgF
	/0DCRXNJ5o8YMpN8n5mI2X+82y714tjD61NZckaIhwj8nH5hHUCAtFyujDpRt56MootNL3Zf7vy
	ZpBz0n1xXroZLK+U+QEw7SyQtUqrH034NMQRuActzqiGICSFk8xZ6JjmFU9s6LbGBNSz4YaLGHc
	TnjB8E7Bd3pw7mN/JNpQLsNWs5ybN9nXd7Gd9vbQ9vefHFXz+1tg0mfaiuY+JSORMhNWz1vbV6j
	+a6W5QmI3D/74vF7Talpp6QXu/ZTeY2b0xFby2JmiRmUfgqsmoK0kl1WiuwMhBhLtHVoyikg1F0
	eunnx181wZYw==
X-Google-Smtp-Source: AGHT+IG1AXC7Sm6OYw7C1ZASw22VMDmIY0Y536r5bQC6IFq1Acx29vK0ChgCjRiB9igtB/mts8AWKg==
X-Received: by 2002:a17:907:d90:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b7070844419mr177169766b.58.1761878496225;
        Thu, 30 Oct 2025 19:41:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779ac3casm49556966b.24.2025.10.30.19.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:41:35 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:41:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <20251031024135.r37lpni2vw32wkiy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:19PM -0400, Zi Yan wrote:
>Large block size (LBS) folios cannot be split to order-0 folios but
>min_order_for_folio(). Current split fails directly, but that is not
>optimal. Split the folio to min_order_for_folio(), so that, after split,
>only the folio containing the poisoned page becomes unusable instead.
>
>For soft offline, do not split the large folio if its min_order_for_folio()
>is not 0. Since the folio is still accessible from userspace and premature
>split might lead to potential performance loss.
>
>Suggested-by: Jane Chu <jane.chu@oracle.com>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks reasonable.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

