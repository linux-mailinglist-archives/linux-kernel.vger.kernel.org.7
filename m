Return-Path: <linux-kernel+bounces-835496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62DBA74BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB257AAE05
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA723ABA0;
	Sun, 28 Sep 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHSwWl1j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B919DF9A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759077458; cv=none; b=hEEMPakDTXOLUjrLOjmVayyTqWTvKPEYud1Drui5EVP+5orkhRnvmheN9dj4yvU2WtWkc7HjtkNvc9ezULeIlb4I5B9PrOy901e3v9e/G6NafIClznhkDgdC2gTeKXmf/2qtUtCb6kcHHHN5/fBKZNjczMuAlfkx1pB/cxRbpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759077458; c=relaxed/simple;
	bh=BKWfA/h4SxKJDlKgt9ivrEnia+romN1DT6uF/si1tkE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HWFlJy07408yDowegI9wfZALZZP/tGzoQc8N+k8hGHQeZkktKG3XLmXjv3ro02X8p+VXbhqo0fRtFJHzKMO6C6rfxxovSRdi341Sz6p5gf5JOXipLtEyLRh/lrDdHz7w0axlOpZSyVw1KtelOxDxhDrc3FdN2dddHg8mY+hDgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHSwWl1j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759077455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swv9fBtSp+iULjidbET4cs1RqWXfeadmzES3l9MawZw=;
	b=FHSwWl1jNFcfvilocqwBooVJ3hOZIUB4veVoHttDH0e44GxP3wD8VWoke0VdST59cVclmY
	vvyLutAczrfoUH08pmyTB3/v2WVeMWt/djzXnemPMcAtep0HqmM1g3C32/7X14iJ+uWUgn
	jtvpG4uFD4tfll4lKM5dcXuRInC8Nhc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-5AaPr6sONgymbwz08-ujYw-1; Sun, 28 Sep 2025 12:37:34 -0400
X-MC-Unique: 5AaPr6sONgymbwz08-ujYw-1
X-Mimecast-MFC-AGG-ID: 5AaPr6sONgymbwz08-ujYw_1759077454
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso67837596d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759077453; x=1759682253;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swv9fBtSp+iULjidbET4cs1RqWXfeadmzES3l9MawZw=;
        b=aReroigetrncfWj1ycXNC4jP4mn0SQzCwmhdP2WvjbkzsYoY41GeHdwbsmPBwRpw2O
         E1XnPtPlUQnzS/r/0dxUVs4mOkqWMHhqM8F+yp9j/rY0kAJypvC+MgvV4ElZM507yFwC
         5HPJwVmSNNnEr3Fh208StpS8l4oG9lvF6/uCoTjEl3tHo7kOr6L9oX1A54S+SFg1FL17
         DDkNhqPxRR1Yli87kVLfd/QOYtxRgKTsGdKPhPhKjuioS1Bb7kr5lakOlUDuflFFBVeU
         KU5CBpGFV5d9+fu2zbsab/+tNHAo6WT2wwiLTXJKmEP9mtjoenoFsIuv3X2Hha3R7UME
         fbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlduGlUAiO8q6AvoOK2hlMBN1G/bzqj0SvlcmFvKE+taICV7vcQkK/ROKSY9gk9PFz6N0fZ81HLsc2JwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKO+2kt6rPGaxzWf5U3p1BalUKIMP7N2h34+4yFmtaV/DThJvJ
	KFMvzGT39WMm+r04CYizmbNg30cbtwlQvXFUBQGBbs2xsL8XbDb6tXCDhwUZCReigZauaP/Eom1
	vCHNOZyoYdxFpe+Rnf+qjblOhu3HvGyo6KFUFxlFwCml/3pP6rP/hflBNFTrq4zJg2Q==
X-Gm-Gg: ASbGncuLXg4ocP7vM03RqoQShiDISdcJOT4bHf56Tm1bgc+5WZzTORRj4XqDO8Bmet1
	wHdnT56qNZ3LDUdwJG7RMvmVXUxIEyaRA0fXJirjlfzPb50wJ1qQK1MG75TGMeh4tT5yLfIVoNh
	xHc1xaJgCbCGy/g68zvof+Wc5sRoz1YkFWlQAV99uJk87ufgTrk5W860p93kAE3YfqX1/lofGZX
	qJWCUK7cCnmJLmT86aSnLjDB9a762hP0Bjk8zS+sSCN4tKOMo+XJ0StY5Hf7BRNrWdjh9hqG/Lv
	OEW8PJ1TzL5cd8cubRMu3zUjyYSdM07N+xZw3P/bUYrh96wmvWqimwn26X9AcSEgTx73qQquyig
	xf8N4m1UuCmo=
X-Received: by 2002:a05:6214:d83:b0:805:b4cb:c97f with SMTP id 6a1803df08f44-805b4cbc9b7mr158873176d6.27.1759077453722;
        Sun, 28 Sep 2025 09:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg81LL1H79NDuoHDEQqMwVQw/x61llS9tHv8xrm7uBc1njZnVB3pO6TICwUrIpHKXRHX9j5A==
X-Received: by 2002:a05:6214:d83:b0:805:b4cb:c97f with SMTP id 6a1803df08f44-805b4cbc9b7mr158872976d6.27.1759077453358;
        Sun, 28 Sep 2025 09:37:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016cf8f949sm56583076d6.54.2025.09.28.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 09:37:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <78676863-593f-4823-9dc2-c08a36f86378@redhat.com>
Date: Sun, 28 Sep 2025 12:37:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: add MUTEX_WARN_ON to warn invalid mutex
To: buckzhang1212 <buckzhang1212@yeah.net>,
 "llong@redhat.com" <llong@redhat.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 =?UTF-8?B?bGludXgta2VybmVsQHZnZXIua2VybmVs4oCm?=
 <linux-kernel@vger.kernel.org>
References: <20250927080018.13909-1-buckzhang1212@yeah.net>
 <f6b88959-aed3-423f-a12d-46bb679820e1@redhat.com>
 <73ba8425.3229c.19991241c52.Coremail.buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <73ba8425.3229c.19991241c52.Coremail.buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/25 12:24 PM, buckzhang1212 wrote:
> Hey Long
> you are right,lock->magic check can  help me to get what I want .
> It's a bit late for me, and I want to get the  warning when I first 
> use  the invalid mutex.
> Can I move the lock->magic check to  the mutex_lock?

All the mutex_lock*() functions will eventually call 
__mutex_lock_common() or __mutex_trylock_fast() which also has the check 
. There is no need to duplicate the check in each of them.

Cheers,
Longman


