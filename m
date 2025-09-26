Return-Path: <linux-kernel+bounces-834453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA16BA4B97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC6316E646
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA4308F37;
	Fri, 26 Sep 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoWTEHTR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411C1E51FA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905795; cv=none; b=c1asUdmlchnCuMfelcVxoBErGFmLQN9v1Xuk8gs1M04jj4zDO4WNM+PCvnJeTlDmyKvsKHxP2MRbbjzs6AlNuC7cg84L9sr6GiAr9ah/uVKtYhIt+8E2VGK6CCOFfE2176dllhOZ5bxy6WQJ80MdfrNeQFl0y4+j4dzCa2Y3kNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905795; c=relaxed/simple;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFNeaeXn2bwPbTnKAtzyHh6/vo8j5CDpgEv3WB37quNHTIzk8DBggHDxEgr2K9P6ItZKSyuUTRg6dWi75m8gOUvzH3yEHfWr7PJ2jzNRKA70bBPnKT0K6FeOdkJgCreIXFqTOm0Qq4uI6j/wh3wqz1Ce25oomXFkyUMbeR6ty5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoWTEHTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	b=CoWTEHTRcUr2vMLRYOgll24MCESPKgM8YVcuHG9vO4n8ybwBQdad2WOyTL1s8zgs8CEJB7
	dDdb8fbUXISwP1V3+6VltuYIkqZQ65Wt0bKsQgfBk0F02MOky+7aGE+o+goREUyQFaGMq/
	uAugh4RoT+k0yyiIakXVFC+fwU3Os3I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-71Lb2P2KOxKshd8aqdnRdA-1; Fri, 26 Sep 2025 12:56:32 -0400
X-MC-Unique: 71Lb2P2KOxKshd8aqdnRdA-1
X-Mimecast-MFC-AGG-ID: 71Lb2P2KOxKshd8aqdnRdA_1758905791
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so2276778a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905791; x=1759510591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
        b=aANHWcsxzo3/22AF9G+JjiRZsc/UsLQZ0bSQRgxLp7WJ5dEk1B7HZfzNnjbxa/oBgu
         w1IXqw8i9fkwB9hQOJX4Joue7i9mb19kZIfcv4sW15RT+DOIw6hdOMIu1+lua97uFp5f
         r4gf+nEe/gwbPqAw4vEeqfc9P2VnWV/xqceuoRPnwOliz2iP57fpeeuJEQrp8jaoTa1h
         kM5lvS36vO29dcv8dYUBUrMogJcW73kmdemjTF3VHZ6ywkjTANvBTaUXmvkpHYmP85Tk
         dtUlGluVXTWkrFMX6vXiItvniXmN59M8emvCXvJ735wIhwo0YGJMOZPD4jzp6VkIyZam
         q90g==
X-Forwarded-Encrypted: i=1; AJvYcCXO2BBI/TmDY7dxNGiO+pLPyTHnefNkL0lQyJpieNFvbMCOsJHNWDneajuhLmnq1cHijbPm5VhprkEyrlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMj7IiyvHztR4rbfQXrkMzgq50ui+8WK5s/pdhzL3Qaq8nqsj
	5g6O6CByvHH0LAt38R33pcXaXTZr2hsOdgAUqR9tWdRRx64F1b+wuJPUnTP4MyowfUmJjOfNZvM
	HXoX2+c5FwWrmxdAVULS2jOIvPom7SXMpqUv8s8xD/IBe7IC2oo6ly4uXM5EUgdYvitEJySLKQb
	cacxr0532KwQT8+/lcfIcP9fVhY/iJHs7dKMpGFY3a
X-Gm-Gg: ASbGnct42qzqwpJdEX/7DbKZ05S8p9BNvbdeQA+5tBNWcSs2riWLgHUKYCDf0TG9ZXc
	m8KLSbaUC4Z9hDpkouqZc6gD/Km4YlR+KJhwP5He0bDNN4hkzxrwLaLFUc+9OR9VrTWSW/E3stn
	mlfXZQjN65qtaTJqk8
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-3342a2e3a0amr9010754a91.26.1758905790892;
        Fri, 26 Sep 2025 09:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/T2nb02ygPzWQlJc91OzCWfWy7tzKbeCqK0AzZtfTw4rJhgRJgzOCPPd+wuatdh/bS3alm4U9h9urtacQQ4=
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-3342a2e3a0amr9010727a91.26.1758905790446; Fri, 26 Sep 2025
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com> <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
In-Reply-To: <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 26 Sep 2025 18:56:19 +0200
X-Gm-Features: AS18NWDruDib3lxkmBnMwisbhI6jtN_YtNKGNRjNW1-ckH59RRm0Bu1PSqLse0I
Message-ID: <CAGxU2F6pZ7Bp53M3fTpSGDQYnrfxrttQc5bDmQLQX0cseW2A_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to vhost-vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 15:53, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Bobby,
>
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> >This series adds namespace support to vhost-vsock and loopback. It does
> >not add namespaces to any of the other guest transports (virtio-vsock,
> >hyperv, or vmci).
>
> Thanks for this new series and the patience!
> I've been a bit messed up after KVM Forum between personal stuff and
> other things. I'm starting to review and test today, so between this
> afternoon and Monday I hope to send you all my comments.

Okay, I reviewed most of them (I'll do the selftest patches on Monday)
and I think we are near :-)

Just a general suggestion, please spend more time on commit description.
All of them should explain better the reasoning behind. This it will
simplify the review, but also future debug.

Thanks and have a nice weekend!
Stefano


