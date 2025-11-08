Return-Path: <linux-kernel+bounces-891255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9BC42443
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ACB3BD7A0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96229BDA5;
	Sat,  8 Nov 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ficmZjKW"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD32580604
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566899; cv=none; b=dsMMjTpysl/+6F0apj9fJkAGmf50arOuZOIJsrRvrD2Jn+nQmxUA1APKrvS5CM2FLGvhBg6y2suC5AagUWX/tqATYp1De79rM7UVwGlr9lDoM8O77DSeKMGTNzjW8FgEEmFug4H5Wfdod5RbuDn4ZH00a6ba90i4YdJyPC9dLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566899; c=relaxed/simple;
	bh=QT7HfEiG1nxjIP/5e3X1PMRzpD1izZm+tR0ZCD8Bd1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDNyBs8yGMsYxsbFWrRAw+BoUAPLX+uh9lwpF3WI4uhZPS+RU9vncWl4Q0eoW/mXq/lUsXMx35/Qyiu6kuv3XrFlmh41XMg3JxEv6re1mwifnFsIrlimwvrC+kkLxhdRVbxvVjXYYABuWfDQVkQsGVUrB+ds4amuPCcfbvI39mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ficmZjKW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1632823a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566896; x=1763171696; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ZmaZCDwiHMLTx2bSrUVe6Saq+o65+OA8UrkrTQnt4=;
        b=ficmZjKWHGM6//HGEpxPPZDdDTw9ZXUYXfbvAg5T7evpvqTQ9DkeU7WZZrLFfami6E
         a1A5zyzFFPUvJsVYeRoP3LXvsowJynHg28xbLhmEmoz2LGI46nIRPTt0FTXUq6r8V+3e
         LNJ7cUMQwIETyAfMJecamW88ZME2tfUB8j6IJDpE27gRZiyiDUnjRC4LZljPK1O5mrJ5
         9nBb26eOjPsCPPr6geazMgi5CxslwIEWakOeoYFbv0NIZVhob5y/G1k/h2tu32tEkDkr
         bbwrnQs5n45m2nHU1aPRqInsV2cTViPm6lD9O96NY/tfBuPd+ZFY6yjgWEqgrx3G9eMI
         Rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566896; x=1763171696;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ZmaZCDwiHMLTx2bSrUVe6Saq+o65+OA8UrkrTQnt4=;
        b=qg5m0N2qyN19ggB6tFOOYvTaD+0aeb3gqKWWKlq8jC2yAEmM6Tmbt8QQ8J/XzeimKf
         997g49CBeb8LLYwUMM431DZBxZGBU+OdkTpaQhUwLPK5OqIAvccIomlc4Jbijy9jOXkb
         NNCl0iJ5hrcFholwwOzij2OHx1Jtg+MvARBG825Zl8Q91GV0Hx+j75ce2BYD9HRzpH6y
         D0NhlHuZ+qxRjnpkOgxS8JmscbD1n2D+16CaxxzO+FjxNk7Va4I4EusEVUw+9e/5ubLF
         oxKMW9rrwqhuQGl6SrLnpTDRfw7X/4zaF50Gk9ya14NgyB8EeRATgg2DBAD+euMRME+v
         dilw==
X-Gm-Message-State: AOJu0YwiCFf1XP2Y5ML3hXHUYjGJ91ATYONihNmQYVXGMBHWl/cZUN78
	dfwmUF4a1LSaN5VVk09lBMpGX72AfudusIMUBH8W7+zuNBPCvod3mCBU
X-Gm-Gg: ASbGncu7FqXOTymi0iGWha/jFVKJFV8RFYINq87IEYDyeuHjRKULDoCtKtn85WZxZ0V
	JX8fODNVSbzs67TA5M5y1zqY6yipgXD1ZonSiGdOHhyFCeMjasGmVv5lneDqrGQJyuyyTEntSgD
	LmjETwGuLWPgZzWGnPnnBgQxOWfeCSQJ2mMYuTSrqR0l+wDb6zrg3fp0E10h8+m7AYymd2ILFNp
	povQapcgNnHnHfkhDB9QBpwOIirsqrlEGk75Jh+/ECqIiNwsdVmxPmD4L0CxCq54WfCV+RmJsZl
	ARGfZlMNgmA+1dx16Ikr+T7AsM5sta5YIEmGfE+yuQUhTUU3O65DOC3WZ55eHsqm3Ju/M6hFNdj
	lc7l+Jy/UZ1NRIkad2nvOla4PGAyPDk5uQ8hAuZENtbn+oJiNVZIoC3xnxmXLUcZR1Amam5tu/Y
	d9n+OLtROefh4zbGd2u1fQ
X-Google-Smtp-Source: AGHT+IETDq1IeCw5XplonpY1pcN21ELAuNqusNEyhCeZTqp1tHeSu1woXZrdQ1IgGv97Z7tZaS+umg==
X-Received: by 2002:a05:6402:46dc:b0:640:37df:e798 with SMTP id 4fb4d7f45d1cf-64146c0cbe0mr3504024a12.1.1762566896182;
        Fri, 07 Nov 2025 17:54:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm5496824a12.14.2025.11.07.17.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 17:54:55 -0800 (PST)
Date: Sat, 8 Nov 2025 01:54:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 03/15] khugepaged: generalize
 hugepage_vma_revalidate for mTHP support
Message-ID: <20251108015455.qc244lvt2pep4t5f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-4-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:05PM -0600, Nico Pache wrote:
>For khugepaged to support different mTHP orders, we must generalize this
>to check if the PMD is not shared by another VMA and that the order is
>enabled.
>
>No functional change in this patch. Also correct a comment about the
>functionality of the revalidation.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

