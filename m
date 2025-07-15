Return-Path: <linux-kernel+bounces-731866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C726BB05AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96753B4F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B31A3142;
	Tue, 15 Jul 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUddGk8q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562D2566
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584447; cv=none; b=eDy0td0+scNlZ/hjdsAllWyHQu+kVxQXEWPqEi5+4Al+A7lv3IT7lR2/2bqPddHrZQRyWmMwVKPsw1CfLE1iTnVUgAL2oUweo24WZE4/zPKr8lGXzmxX1LYrGn9HNjm77iY1yYEGw/+Z6mIUdO7DSzV2bONOXnWQLHCTPCJogg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584447; c=relaxed/simple;
	bh=nRKeg8nDzlYWzE5XInGEwKQE3e+XD8za49IF5TuC6t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=l9xLLidbcYRmLqVt7ur5Yc2JkZATF0yyAU324Wt5ZpyFMgXpOJgAgbClzP0CsNvVNoRANE65eQS/cOuAkOa5j60QW41ZxpHolQ1HhxAhUyDGqFgSNNkv85SMY44b2WaJ05VwEXU1jsI+ltRGQqHejULIZpIcoJrQ2CJ2A1IJyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUddGk8q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752584444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOb/M3X4bPhZw5/ISg0MVilrU9KOEKNMA4Ln3msvQA=;
	b=SUddGk8q3Xuiv/UOuQLC9IGsd/bdBsxvj2wI0i3/eAq9YpaLBDRCljYM9z80RNvhBLW1Jg
	ka5jsz5NOUXZwCUinvjH8RiDw4BqfGZ6qOPU5kvSBbbAfRjhvOTQtyoWC7I6Pqqd8CBVx2
	Po7g/HU9ibV2c6Kf4a6rq+HPZ01Pml4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-YZkHqqQNNHOKFLUwLPBSFA-1; Tue, 15 Jul 2025 09:00:41 -0400
X-MC-Unique: YZkHqqQNNHOKFLUwLPBSFA-1
X-Mimecast-MFC-AGG-ID: YZkHqqQNNHOKFLUwLPBSFA_1752584440
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2449343f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584440; x=1753189240;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTOb/M3X4bPhZw5/ISg0MVilrU9KOEKNMA4Ln3msvQA=;
        b=aGiQ1fye88W0Pi44ew83LepCwTB4fSGaFhI5Rjkq95OG/61hrPMl8h+YBq8Onvjf3P
         5hAWKnsYY1qcYf5P/STiWiV9QwUcndpeN29ZrCfmJ16S6bEIJAImhg/f4ga89bAA7xgg
         HAPJDoBFJNhzAz8yLFYnNSMJD5Amlz1Vr+s3xju1iSjI82gP7ZMuSM9hqvpsuC5BP/TU
         GSCqJpHipfJd4IK9R5vGDD20Kf2uxgppCSP5i84/11YXSuu8LfY9txsXXSCHzUv3asSl
         tfQBISZ52y1FgQuZnHEoIDQY74iZRXaN+RiEQydjtLnN4OgJlDGOxiQ4yRxGaD/tfVjG
         vfZw==
X-Forwarded-Encrypted: i=1; AJvYcCUqgy+ErG4EmBQq65Lg8IIOVmEBK+POcRVvED6z1a40HkTDLiy2M+4X+mZrt+p2nYt2evjKRBscb4Lcx8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxef9o1ffDAToV5KCLDgFjcuMzgq347x6vLdWtaQblEzTY5wqde
	cUNr795OoIyKvlM5frnLuj6v6pd65QfE9ciKW9ecVtQ68/hvXAXx41v2hENBBvKroSh8IDjGg4o
	xYInI2BnXVLGTRMJYwT/5UblIr8/V7A/qBDotg5TIYtsP0SHBOPuK9I5lgQz0A1wWuA==
X-Gm-Gg: ASbGncuKdhVAHVow6hK9bQjqoWRxCUfY33YtJa0TuLhII5MtVuLI3QRfHfcDSeeUbuO
	xoGPI+JUWT0R3AE59id/621o4LzrQIGPPaox8XqKk94nFK2BNSlKsYuVF45S1b+FZd4mxqZBBKq
	Ge2NMkD3iYd4vPYZHhBb27+mwiZHRkC0R9wEwnbF1Y2izOuKAo8FK+BJJh6eNrROrVB5hmJnVwC
	WSGqC+KaJ+eK/K5KdyoES/Y0l68KpFfPBf9Y+P+rPoYsuTF5HoBjqczevJBljiqRtOH2Z7DpB3I
	t64yD2leOiilHRDTLFrvjO9pc59JbAab2a9Onnuy1z9x1Vq+pWpg2GYw5uo6NJ9OIi06AzMSIkU
	JSEs4XMTim+nEIuR4cbZnZMg=
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b5f2e3a02bmr12684759f8f.53.1752584440012;
        Tue, 15 Jul 2025 06:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVnW72xbgDwMGMGrLLaIH2UN+xI4Nl02JsyqBjVGQk6nMJx7+WMekUv0v5WCGEQkp8RbKskg==
X-Received: by 2002:a05:6000:2884:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b5f2e3a02bmr12684708f8f.53.1752584439527;
        Tue, 15 Jul 2025 06:00:39 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm15164588f8f.71.2025.07.15.06.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:00:38 -0700 (PDT)
Message-ID: <ea729bcb-4aac-48c2-9f9f-4eb8b59d1aec@redhat.com>
Date: Tue, 15 Jul 2025 14:00:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
Content-Language: en-US
To: agruenba@redhat.com, gfs2@lists.linux.dev
References: <68764d4f.a70a0220.693ce.000a.GAE@google.com>
Cc: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68764d4f.a70a0220.693ce.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 13:45, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in move_to_new_folio

Known issue, fixed in for-next...

> console output: https://syzkaller.appspot.com/x/log.txt?x=11eb8382580000

Looks like it's hitting the new validation instead of the UB anyway.

Andy


