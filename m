Return-Path: <linux-kernel+bounces-854090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A367BDD83A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9574FC99A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B6316901;
	Wed, 15 Oct 2025 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep1mpxHd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236A3176EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518217; cv=none; b=luUkjbsPTCTWO6XfOkyvPbQMWR/x8kZ/9S/1pKuiIkV0wII55wYstmcY6hkAzst5F9VgwQFm6feaA4fNffM7P6zFUX73Tgd/8DJoZDICRqHHZKwuhGvSGf2KT6NcuF/gMW0sCvR1MZT0tYmrZT7lgH1x35s83pmevdZIukRlHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518217; c=relaxed/simple;
	bh=rjV41cN3aYKmhVkBt2Knej3M+tWKSYPeVxPuPt2pbRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tuvMhSEXrTtMR0HGONgvUwqucRS9QmQXgcUZmFOtet809as3fOhnp2FIN/+zQs2rgQSLT2YYEl5KjCcx8lW73/RGyob5U9SY3iVpefLvpVrbXEmYXEobd+nJxXl56I44pq7AN/gQe6LCH+qrgN+7iam4te0DMmMcHU2Co3EuDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep1mpxHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760518207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U2xYcEDiEp3Ua92vFalk7I21nwEzPa4pjb/oKqCkfyw=;
	b=ep1mpxHdRo20i3x5lEobrmgDeSBITW1eFeck7tSVAJ/+1VWvyFFs+nTkGsqNEUHCOeQFf9
	BGvUhazFp12nv2TPlQhCkrZmA/YL7q139/g2YpFsqk+HU/8rPHfVjsDbew3dz0TUdmprtK
	FotoktRkh9L5F7w/37j4N5oelO2UZxQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--j06hzeyNG2H9oWY6-ZtdQ-1; Wed, 15 Oct 2025 04:50:06 -0400
X-MC-Unique: -j06hzeyNG2H9oWY6-ZtdQ-1
X-Mimecast-MFC-AGG-ID: -j06hzeyNG2H9oWY6-ZtdQ_1760518202
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26e4fcc744dso67097445ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518202; x=1761123002;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2xYcEDiEp3Ua92vFalk7I21nwEzPa4pjb/oKqCkfyw=;
        b=nG7YLtnRlcOkKvG6IA/7lIFQsHDjV867mosrj9CWkWYf6BW1ogTb7AnvetOnQXwVfg
         E9xub7NTRDlOMViiLmtO0waYsZncMyK/OaytZ7D53Qs71GJU1W/cAiZNFdfQJPGORX1X
         GrtyukSzE0RdCRrNJLAUPT8rNc6Gu/N5BLf5I3Rw7IRjYAG32GWKPTHRUtFKdRG3nbUW
         +EebDZsvBnnXJsJ3CcyHgpXMsSd7lDK1HwVyWBm2G7JgROZ3gay0DndE+svR1tGv3Blj
         liL8I6FZvfylm/uHYswqyQe5HLQ/rDXu7YoHajjnBLEp/+CH7JPul929e9ttHzEhAUfh
         +G9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSDhEGie2OHrcTyT7f+dF09ZU00zz8vQiAaXy+NmVVcRDXhOXigA+5+meMwnQgUnyBSIiD8njjgoJfQRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9m6yMVPu5tU4mVS1SbdXGIv0lnu0mXkCKH8lj10S6AVkDzugp
	j0l//1APpHiZt0KLQM387S6XnZ539k/dizic73Ov6iyNjSCDEXwoMo6Jtg7dFvHVejGOGzoyiuT
	ae2s24L0Oc1ev7eQUv8unXkIKtRcHmcmLsUV4jKAXfPszU63bwM7kpFi4/2Nz2faIVA==
X-Gm-Gg: ASbGnctbm7vIqIT7htZZ74BvO4oI9YRdqS3JiTaYpZ4QYtPBZP2+pfnYA//XUg/MJ2T
	UNkRqCnqMYQCNh9X/Ge2nOk3b95q1btDh+XVz0lOga2Xai4Q/lEco8s1e3R6QCBMFb6t3K3YDRi
	fmo7VuhwUML8Yz/XTZJC7D/CojChaeIyfiLEpIJ4Ub3KJPtF4HdUhts1syQP78VwbJvkXqcEZF9
	yog5BmeJ9JgVESTD44RZsUrOBh3VHjIUI/gIhltO8JIVw0WkUytWKviUqzhZLrUH/Ff0TgcSQEs
	sAuM6lc22viOBTGn1YJCWj00QWRkzlng3SSd95mGhCT2GRiBzbbGjxga2av6Jk30K5HyqCv9Lwu
	COBqu2utdIEEs8+bafLBOTw==
X-Received: by 2002:a17:90b:4b8c:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-33b5111895amr38382002a91.14.1760518202342;
        Wed, 15 Oct 2025 01:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbUHqU3QKHS+2fc/9YjRXO1Nbn0rMLG6Td+fbVm4EuDdA25uLsveQIn0KOX3/VuwxdqJbmA==
X-Received: by 2002:a17:90b:4b8c:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-33b5111895amr38381981a91.14.1760518201947;
        Wed, 15 Oct 2025 01:50:01 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cc5csm18897294a91.10.2025.10.15.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:50:01 -0700 (PDT)
Message-ID: <8c2c9721-e2ca-488b-b7be-c58170f6ceba@redhat.com>
Date: Wed, 15 Oct 2025 10:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests/mm/rmap: verify correct RMAP handling of COW pages
 after fork()
To: Itamar Dalal <dalalitamar@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "riel@surriel.com" <riel@surriel.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "harry.yoo@oracle.com" <harry.yoo@oracle.com>,
 "jannh@google.com" <jannh@google.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "shuah@kernel.org" <shuah@kernel.org>
References: <SN6PR04MB4048CF9A242A640B29A588EDFEE8A@SN6PR04MB4048.namprd04.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <SN6PR04MB4048CF9A242A640B29A588EDFEE8A@SN6PR04MB4048.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.10.25 10:43, Itamar Dalal wrote:
> Add a new test `migrate.cow_after_fork` that verifies correct RMAP handling
> of Copy-On-Write (COW) pages after fork().
> 
> Before a write, the parent and child share the same PFN. After a write, the
> child’s PFN differs. This confirms that proper COW duplication occurred and
> that RMAP correctly tracks page ownership transitions during COW events.
> 
> Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com>
> ---

Se my reply to your other patch.

For the next time

a) Use git-format-patch that will automatically add [PATCH]

b) Use versioning, e.g., [PATCH v1], explain changes since the last 
version under the "---" the

c) Use RESEND for resends, e.g., [PATCH v1 RESEND]

d) Use git-send-email to send mails out

The b4 tool might help as well.

-- 
Cheers

David / dhildenb


