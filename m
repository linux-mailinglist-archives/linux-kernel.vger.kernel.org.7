Return-Path: <linux-kernel+bounces-835129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42490BA6568
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA63F17BAF8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720B22D7B0;
	Sun, 28 Sep 2025 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am1VXSyP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558841E5718
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022986; cv=none; b=lJkw8oi7aaa2rWNHX9bqjcbrzyIBVcGEJ+eooT0GeJv8FttBZy1JPsO8YuAG1UDgpmvV31rtHq8m7Wyjvc/dB21OlOG60cgS/mdA4NdelMUxi++GcCIuhKWUmJlMn7QOlI+Y+POtrIs2D1Zcg2OI7STe1N5nl8FzROt7M5MM9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022986; c=relaxed/simple;
	bh=tYaAYB06afOao3vif5FoPI8ItokVqPkESNwatJyJG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuhLyZWTZ+Oz0YtJlN3XEl3GEOT/ZvuMuh14mBZgfEjRAgb2TnCSx7QkUqaejdqacOrdSnXeWL4eJ0aWGLTt8lertBTTIJuNvq4EvJjYpDRlumfi1D85kh+3bvul9C+R+bDny1FHG/OdhpWvPaz/ZYKH8HguhPULjWVmKV2bTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am1VXSyP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso6597185a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759022984; x=1759627784; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaaA7VF/d1dd6Y2aehhgBQqzOxirTeBTgDR7whafJPs=;
        b=am1VXSyP376KykB+RPq+bBgczDIRjnsJHn61Vp8qGWMioGW6hd9uEORSbA7039vRrK
         AzVIL/8oKlrjIVOmsXMIE2UlkL97iiJPTKxiWR08BvjmX7O46FcGkKbcnlPTNLVXZzFd
         3qgW3+PGPTWX8oT7C0KfPuLx+4mFBZ881XSq2GpaMk7sYpl8sP1LhROBmeLWS+PgpyBO
         zLYRD9QaO7igJ5jJIa4STd/QTWwRXzLLpSnW32OhQOE6VdNhLJ8t2N0AySBwfH7ojQuR
         FplikifHEv3y4dGqvOyY9dtizahUJpCITnq1MyV/6wz0G8h9nh9QAkvhNt8Nt5FKkT2G
         RAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759022984; x=1759627784;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaaA7VF/d1dd6Y2aehhgBQqzOxirTeBTgDR7whafJPs=;
        b=P9LNGRzFu38O+3B+NJpbSzcxUC508eavocO57Q6ywamnxYAaC06g2xkMbdfqcOQQ3G
         cEud6xIOP2RbEp59C2ZaQ89EQxYNfN2xARWmIYCAdYl2C8P0sQ0EkaySOtgsOflSc68/
         SH7YGh1V6y/R2pPELl0o3O2tsimUsX0H5/B6/vyjgr9eoEPmAKtscoFDDoyFNE59PDFf
         gBpnRlxBB7sPKhSuYp5dxVFWJ337ZlTvsvg1+ed/BWIIr5BfbnwNfAi8DIfajqA6FKJb
         Ha3QMGTo2rpBJ2L+RDrjfZwMIuBaHvwyZm0b2w5GqCr8c7t6Tm7Grc4j/sI4CrLKc+oB
         bsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUu6WWMYiUeRSKyhJoTXve7EHJQFu5pcyibTn4bGwBTWMsuuuepLcqImJgMi0zyvLe5eYqYD+J1s3pTNaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdIfpHfhfNV8JUaMLN28yzLT4QVAxlK5/n5FbJF8kTQB72wzW
	csoz1RTx6FQ0bmQxyVl5nO5oqd1nFvK93jpmwVIP81FiShfSoW2AQbXE
X-Gm-Gg: ASbGncsP641U5HwVN534KKtFFXI2jZBuABfU3yXIrSOn+0FlCbsrXBcT77oo+47FbPw
	BYzmZzCQy1hGAk3Ke7crEbRZlwYIHpX/hScN/7cvAFkWEtzOGpsEx20sVByQHMXo2diRuf5E1uy
	m/10x7MuUajnsGH29AgmZFN1D4rZuoI/scEhhs7EKsN+oskQ5pUvrDlkU5lZ5J3PMhUfFRDTjOH
	HZeW6XnRmXES+G2gLNrW9E4dFVdX9BsSvJDBgxWgo54fc5uYengZ5EA8Ob9VsoslJMiAvQyybvp
	XiuCSBk9QREyZWrFM5p59Ba3pL1PsXiVrNdwzj+9bQetcpCuXuMj1NEy/Hh1jU/ln2abeys3prG
	TBIs0I8gxDLjnz21PB5dYe/LiVA==
X-Google-Smtp-Source: AGHT+IH8PMCyGq17Grbmlu3IHSZf8Q6pFvykXtFEHcjxN4vNb3KgLD91h4nEUAxKcQcxVpCFfsUfRw==
X-Received: by 2002:a05:6402:44c3:b0:62f:ce89:606f with SMTP id 4fb4d7f45d1cf-6349f9ef17cmr9469195a12.12.1759022983448;
        Sat, 27 Sep 2025 18:29:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634bf4a5351sm3206980a12.43.2025.09.27.18.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Sep 2025 18:29:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 01:29:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "jianyun.gao" <jianyungao89@gmail.com>
Cc: linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KMSAN" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] mm: Fix some typos in mm module
Message-ID: <20250928012941.wildyant57igw7zi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250927080635.1502997-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927080635.1502997-1-jianyungao89@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Sep 27, 2025 at 04:06:34PM +0800, jianyun.gao wrote:
>Below are some typos in the code comments:
>
>  intevals ==> intervals
>  addesses ==> addresses
>  unavaliable ==> unavailable
>  facor ==> factor
>  droping ==> dropping
>  exlusive ==> exclusive
>  decription ==> description
>  confict ==> conflict
>  desriptions ==> descriptions
>  otherwize ==> otherwise
>  vlaue ==> value
>  cheching ==> checking
>  exisitng ==> existing
>  modifed ==> modified
>
>Just fix it.
>
>Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

LGTM, thanks.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

