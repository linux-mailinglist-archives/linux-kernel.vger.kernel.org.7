Return-Path: <linux-kernel+bounces-877358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C198AC1DECB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1FBE4E4B70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19201FAC4B;
	Thu, 30 Oct 2025 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjZ1Rx9w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBD1F4289
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784523; cv=none; b=j+7aL3hV212ROyDzf0KwgvwSxwkCehFQROMtKSXmUFHlMisSFLVJP6/s9LXBwqhIL20XSgpy7SnGd5q3MZ9Z8STyLPLnrBYf7poaIvY04zrPZOW2phJl58qLOikgr9umrU9quAVLwhA0VD1KptSYcucmYdufr7/TvidcsZdsoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784523; c=relaxed/simple;
	bh=IUoyLvpsMYGmhZ1JkQITddfw7O2lI9KoOiDoJhY8Eys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCXYXuLwYAangO2TE3zTc2ocBKMT6mGdDM2xLMdqBwHaXa7aDRrsozqzn/aVkrjXSVsPPWx94Z7hFPzyE4dAL4+Hq11JQsy65yXKi8fnjQYlqTBMJgiNBXfQwKN9sfGo8MB8P+Zmxa/bwc6cLj5gVlS9Y216Dssw9CexKhRbViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjZ1Rx9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
	b=DjZ1Rx9w1vFi97QJ24ouJVoBBdnpU+ACPYKF0rsaP1zKDCFt7xLkUoXRVzo/i90zs/BuCc
	GmGCQTJD8GvzAtCwa+Ld93TEo4zivLfh4l0JFMOIddpSP2tiRTRJpCtxmDMiP9IZNZKYI6
	ZzQ0mAm+hompFofpcy7vEWSl4OfBNMM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-nIUtUoMyN_i89aD9JSeIeQ-1; Wed, 29 Oct 2025 20:35:17 -0400
X-MC-Unique: nIUtUoMyN_i89aD9JSeIeQ-1
X-Mimecast-MFC-AGG-ID: nIUtUoMyN_i89aD9JSeIeQ_1761784517
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a26c0c057eso424006b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784517; x=1762389317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
        b=cvEZem/7/ibsvCYA7yHs3dU/rmsbEVw8qcWlE5Yun7WFnyi72Uj5bgX4lQYdWPcMRw
         8Ha3xNuoOLW6u1R3HrnQP4KpcQHGLjYH5gSaR7ENzdxdRztv0VqxB3t1nSDsLOcSVj1R
         puVELo2IxeR+g/K1Yr+QGDSilxlY96leAsLk3dFBBvAVJHA5CAaatoqUEBv1rsk9Bm1w
         tgR6jbhDJvlTKuduN40qR2VINmTlaq/QJ3UJi+kaTDam4pLp0tx03MM5XRtfcYQmsgDX
         utx7BqC/BEhq4WVC3twGqWogFysHxMFMqNC/oxzqOjoS0gGlT0KihJKNwMC3TAnFTjrK
         YEcg==
X-Forwarded-Encrypted: i=1; AJvYcCXgPahTd4dvRfy9hop8vk4Rjf66TnP40TdZE4S/d2r8Tgw1lKPpJa/xyzorFjchuPMz8NOluRu44Vr6Ses=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFOsL/sgja26Y6TFxYhYzt63XezTNVp010YvNATjVWnUDUGHB
	LFGh/92jKlQN6lU7e51tbSmBF4mRVd+0fYybiOCvecH0T6UFnT67pSCFpCpQ4xS5/4oVqovsMbJ
	ljBm6qh9xGyuevK8OeCPD+vMBhjed2PO1wWo3+WqQ/chZO7Aqlo9mUNKWPJOYFEXiiA==
X-Gm-Gg: ASbGncsb/041tHhb53yqIs/8VOVDzevinb6oV4oBiUVC99vxqLhaNlN45yifL8Z2lQp
	aveV3m3yIZoLdVNaV28jNb59o8L80l4LAmcwRs/VKDdNl1LgWwHzxY18GUcWR24Sl+83p3+fGc8
	fw21ohqjSmB/tMBcsDT1lrDnWywRtZijybgyzVXzSBpGZ2yoSjhdFhf2vJ6yWCOqCNFs1nMAKEv
	Lqgi9JMez71wpVstGAai/gY7WYB12A3h/F4Vk+usRZyUwJchz2RhrBVp+8Ey3BTFdFhOSdntYRx
	9UOqPe66CPwsXd06nhvSFYRchdmFWYRdfiioW7en0Xf5ih5Fu65X/0ojApzM23NNrg==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293645637.44.1761784516651;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFio5AWXbLCe0GCxiEDNyLa9vmvddUkVGViUSSGWOijdJL70pEBNvbe1p8oDpeQ5+ERrHT/7w==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293612637.44.1761784516148;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm16488075b3a.38.2025.10.29.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:35:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:33:33 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <h6jeu3yf33p2ngcvaczjrghm3hunkjf5gq462njghryyc2qeph@jdug44kw6tpb>
References: <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
 <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>

On Mon, Oct 20, 2025 at 09:57:19AM -0400, Mimi Zohar wrote:
>On Mon, 2025-10-20 at 14:45 +0200, Roberto Sassu wrote:
>> On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
[...]
>> >
>> > >
>> > > Another thought is to make CPIO support xattr. Today I realize that
>> > > ima_policy=secure_boot can also cause failure of loading kdump kernel.
>> > > So the issue this patch tries to resolves has much less impact than I
>> > > thought. Maybe we can wait until CPIO xattr support is ready? I'll help
>> > > review and test Roberto's patches if this is the best way forward.
>> >
>> > I'm not sure of the status of the CPIO patch set.  Roberto?
>>
>> I haven't had time to look at it recently. I can take the openEuler
>> version, address the remaining comments and repost.
>
>Thank you!

+1, I'm looking forward to the reposted patch set!


-- 
Best regards,
Coiby


