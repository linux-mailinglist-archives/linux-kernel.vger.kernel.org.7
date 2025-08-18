Return-Path: <linux-kernel+bounces-773632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3ACB2A34C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE723B0305
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBD31CA62;
	Mon, 18 Aug 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN9+xZgW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860612DDA1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522110; cv=none; b=i8//b2dTl2J+HQBNrIl8EHGa5Fkc/OFNKkdcciXsl1iefgOGQR+VbUfCijHOhSQavP/7SnAuiY0hJ2gKVUAFcz00BQakH5QBM7/9QiFqQ2lkqW97021bTiayVgIwje0FWmEsX93WBPsBqaGIUeaVAbVgjsNeKbnLfWn7KQ9Z+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522110; c=relaxed/simple;
	bh=MQRSjX2skYJbxQ+ExN8UwU9x56c0XGCvrn48q/yLhUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cSSyBc8GsiHbp+kx8P91w5jq9t02QUsK7cVJ+sQIgwwQ7cKQtt6gYhp+XlN7MJO2uGzsblcYE3tfjMEjy6qbhghDEdz/a8PQrlGYAEKoyf+CRDyrj0yUpJrG+mHe9nOTLLwhcYE5eg6rv+ubgR5qiGsN6qjM823jc0XQXIpubtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jN9+xZgW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755522107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RThlmLPb+EykYg8ligo7HP1ysvF9xQvAuy2c5Z9pU1Q=;
	b=jN9+xZgWESTqFH2xW3fAttPx2soHWcpgyVaHC6Hp7+cdw2jwtMXNpcEYwrm9NlLA5cHp4d
	VTmsdeRtkorWGtxtNWFY73uEJR2iJzvssMjSMs0JyRCfCOvV61Gkvpow9R4fCpWGlUIbDL
	MNnxzRoiO2QhRBRySilT2DT4z10kSJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-YYlxEOVkOhuWuwy-8W97jQ-1; Mon, 18 Aug 2025 09:01:46 -0400
X-MC-Unique: YYlxEOVkOhuWuwy-8W97jQ-1
X-Mimecast-MFC-AGG-ID: YYlxEOVkOhuWuwy-8W97jQ_1755522105
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so17673615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522105; x=1756126905;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RThlmLPb+EykYg8ligo7HP1ysvF9xQvAuy2c5Z9pU1Q=;
        b=msZM1GaZ1Gf36eKFx0rRegozwgyzpNp6F6ffr97T8dtydqLUWSTyFUHT60UhYp3vOL
         QY6CKjusKyI+vMpJ1vftbiVFJu9qDsUwgooy4d50cYKykmyIBj8S62w+l4Ah3T/ecfuT
         RBR7303ZqPCGkqA+1A/PIQtyOqXsWVT/sE1cCMktApmbEPoCNIpUlvKJh/bEwVR004gf
         A9+bB7eOP5+JcP01xJ94eQ7mMudJnTnrEYEix6Xos3e29AO3XPTqtHNaI2j6Z77TtUJB
         h1h0VJD2Xj5CPIxSH5I+VhX8LCfSkiABzX2m5heNCBw/A+hOp+Xp1JOYdJgAQHA8BCXL
         vW3g==
X-Forwarded-Encrypted: i=1; AJvYcCXdGALJ6Sq308vDYXB3QN+Y8L/+qCddbGOw44jG5wAdYA/Rh/bJTiBk2mZvZ9WE/gmuiWPt+g/tv+OUlRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1VEcSultaLO0v+xBr9r5EnZqy82y0VMaIZ34yEr9U5BZMVly
	qmS27zHDrpZke5y5BDTnZXo/vyEx3rsC3ugZMQfMtxCbRBdpm8NkfLhxwhgtPr+vz554h7pO5W7
	ReXZd3EzGSK9WAKtkAkvjFPWtEnBuCC/ZEvI3zYGI2LfcRqr5crbWJD2/uReXNQdLWAMWNJ3rHg
	==
X-Gm-Gg: ASbGncvpcVWkqFlMOY6pUmg0TuuXFCHCG1aQNhDCRtniqZHAQixbtu+I6UjxKdLWn/P
	50AAdXHaNv9zP4JE2X8nja1CM/S2xpA9GxXqyuzPlKGxXDTlDYoCgiD07M9hu22nCbSbe++gzGr
	2czG4YAC+pHc4BXzjadJFKq5IXHI77zVi7tM2iSWc5E8PoL19DKyk7w8Y7OXTQJLdh9Sv0CM6Fy
	HcfaJN7lTtI4HXSvJ74ip8WrpcmtolgVb19QgGIrppCz+uttywynmlAO5h8lar20oWifToEZZNN
	2kl6jc3KEoFVrXdL54Hp7VCRUyyX0iXQGbd2Jh3gDQBrwHW40DeJFX9NhDdRixg2eIQymrD4ToB
	ZQjfTlDDaY7qPQj7N4te8EJmf4jQCenrKyp6t6pj+mwxBlvxqC147pkWE3TZD6AIQ
X-Received: by 2002:a05:600c:350e:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45a2679e090mr80917105e9.30.1755522105059;
        Mon, 18 Aug 2025 06:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqLEQpuF/rQnrNlUPYRGzvZNoDdGpC9BmyZtZ0WGAHqRAhiq036JxW235aHv3Ksodxe/Znw==
X-Received: by 2002:a05:600c:350e:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45a2679e090mr80916565e9.30.1755522104489;
        Mon, 18 Aug 2025 06:01:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2232fea4sm135100235e9.28.2025.08.18.06.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:01:44 -0700 (PDT)
Message-ID: <f07b06de-77e4-4d50-9d97-18590faf0b10@redhat.com>
Date: Mon, 18 Aug 2025 15:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, harry.yoo@oracle.com, jannh@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, miko.lenczewski@arm.com, peterx@redhat.com,
 pfalcato@suse.de, ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com,
 vbabka@suse.cz
References: <68a322e3.050a0220.e29e5.00a7.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <68a322e3.050a0220.e29e5.00a7.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 14:56, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to apply patch:
> checking file mm/mremap.c
> Hunk #1 FAILED at 323.
> 1 out of 5 hunks FAILED
> 

#syz test https://github.com/davidhildenbrand/linux.git uffd-wp

-- 
Cheers

David / dhildenb


