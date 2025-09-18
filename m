Return-Path: <linux-kernel+bounces-795799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297EB3F7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6031C1700B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CB2E8DEF;
	Tue,  2 Sep 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYGVaIJa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377D1F237A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800781; cv=none; b=TMp3BKwvdyXCW8YM6PKGjePF4Vcj4efVhua2pDzNMLMnL8G2ihVKQ2aie+JyTEPS7uVQcgOxxYzkfExm8tBDc/5nJsGqHe3wUBSuBSgjdDoJ1mKh74l14HpJHrxSO/HMgxbmJsrahqlXHk0vcR/ZgtfetDsO/yamY2hnxeVnKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800781; c=relaxed/simple;
	bh=9sIzBhJAJecUfR05pFL5MhdXUERao6Vy1uysRMC+oWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhdT78u/HSq+oa4j2EPgOnBgwr1CamVfRAeA8aG2fCZdPk5DDUvgh5j9McEaAmSL07h7eKZz9on3K5QLDyFHpqut3W9Khybd6oRkQw0B2u2F9Q8HXxxOPRrMBn36jMJ+NFwEC/EgRO4cGZrbocQ73iTpR3fddEPPHwfNpZAh9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYGVaIJa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i2PX4p6Mtju8RFE+SihzC69gvPquXPYyNnCIBLJZnjE=;
	b=YYGVaIJa3UCQv0TOgyJTItoQhMnlwMX30m1ytUbVNzmHnCmBJcQC8zyDfPXlWiyn5acT9v
	aFohOCMsZ6GUJQbw7VY5mOYMmlTzynJzgOCipk97eQCeGGRDrx9SFHd5mANRR8NKBFS9nP
	Gg+9lkp0F9q59Mvf9lOwMmL9VDyksWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-kXGDyxMdPZ62gvmNl0rQTg-1; Tue, 02 Sep 2025 04:12:58 -0400
X-MC-Unique: kXGDyxMdPZ62gvmNl0rQTg-1
X-Mimecast-MFC-AGG-ID: kXGDyxMdPZ62gvmNl0rQTg_1756800777
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3d2edf6af18so1296140f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800777; x=1757405577;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2PX4p6Mtju8RFE+SihzC69gvPquXPYyNnCIBLJZnjE=;
        b=RsAOjd19zw3AVYw/gTrm1d7cYH9nYh4U2ML5m0N92QV2hegWcqps9wHAq9hUGyjw//
         sa/MYgYUnFA4mTpzHLgss1AiCWjwMYWsRtwnAzJdHsufFTYbSkfFjFSzXs99GmvoXFMd
         IfgeeHDaUsJFPzit8ft/qzBKE14yx8+axsCi8gddQTyRUD4b4DrvGDXwh1WSYSeLPaww
         gXLOi9aVuOLENglithZmFpk+1178Ggb04/YJc2G/muw2iFKfYp4KFRQRvBZMDeUNJzVC
         J/02GzvdHl9sSD5VBezdlb/A7PscewYA6sn93AEEalA9VDZ5VYA37MXgNYW0BZgWxvQr
         0Xtw==
X-Forwarded-Encrypted: i=1; AJvYcCUSCQD6GJDsNiMpL/5Rysx2d4M81aJIvV731Vm9gYPgEAaJeU6k9s5IfRuKjCdZJcKVRIGHO+OTxUciGYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys562fdM15DddAcwAmRzr+VC0eQqKO1VavHH6v7RVmWkVJIfRv
	j93nHikwoltiroXcNu4gKGEGLZUxqzXEeDC7fOC0cCFIpOnhziVRo1+F/TJ4JdV1p3I/CCZFCsi
	72ESlvWKh8ylSrZclT/0cBDVh/ZB6Xzyh7oJkH6QlXDy1RVo1nHVYZvkBghZRNp6zzQ==
X-Gm-Gg: ASbGncu4ZXLM6TOVfYokgCJGGtqFMJTNqGgK0Qg2gqZhhxey+jrCFYmlX61CC45ggyB
	7sIzRucgjQtpRQnFYrNBoJphfuSM/6RSPc/RgbZXo4wDOr+u/N2JeOm/wbmYoeei3M/gfnFssWl
	nsaAAa3joRrIAKeHMc05I7nOLNMHjAjSmK8vBl/QSyDpicyC3xTLsMtEVWni7MtW7uJDOpFyatH
	CKLD40VP9TjG6CiuwSHwKH+ADvmNI6TnagjKQFhQzdAnrqgvSa6jq9v4fhEsUyhzGMSYpfG3nQE
	h/OrfpV1q3NTxkblxH8fZCUyawpMevL6JmYuafV+OwJ08Lz1fD1oYcy9fIzcqvInKLHQYmO4B33
	OdVnLeTn0u7kEWtzVbziBGzcd2NWjfbZ0GSEJE883yO2pr/NZyG5JpCoJLp5S+qmqH7Y=
X-Received: by 2002:a05:6000:2c09:b0:3d4:6abb:7e01 with SMTP id ffacd0b85a97d-3d46abb82d7mr6181308f8f.41.1756800776974;
        Tue, 02 Sep 2025 01:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn7bkhRrar0ZQ3XOJwzIcLOk2yUKXwjDdnXi/Wtg5Y8XWy6yto4/cZNv0ETOrp232NZx1u5w==
X-Received: by 2002:a05:6000:2c09:b0:3d4:6abb:7e01 with SMTP id ffacd0b85a97d-3d46abb82d7mr6181287f8f.41.1756800776558;
        Tue, 02 Sep 2025 01:12:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9cebsm18516909f8f.46.2025.09.02.01.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:12:56 -0700 (PDT)
Message-ID: <ea4dae91-2e20-4e29-ba00-b73e6160332f@redhat.com>
Date: Tue, 2 Sep 2025 10:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 kvm-next] KVM: guest_memfd: use kvm_gmem_get_index() in
 more places and smaller cleanups
To: Shivank Garg <shivankg@amd.com>, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250902080307.153171-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902080307.153171-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:03, Shivank Garg wrote:
> Move kvm_gmem_get_index() to the top of the file and make it available for
> use in more places.
> 
> Remove redundant initialization of the gmem variable because it's already
> initialized.
> 
> Replace magic number -1UL with ULONG_MAX.
> 
> No functional change intended.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


