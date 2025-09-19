Return-Path: <linux-kernel+bounces-824297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313FB8899C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A491898EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F292F25E0;
	Fri, 19 Sep 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+i68S5a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537ED2F39CD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274617; cv=none; b=lQnzX27FXKxyJVjrlwyP5oPoYIx6scHrKwiv57klHA7JMRSDRyEvtyDt2w9D4uUEy7ZcH4MtOsf3COWCoRnyRXIkAzw8cI26YbxKdnh90maWp4bez4RuBWxVGryo6BeRTI8vhxvgd/L9jTrXxTFBXKvK+ouEETLNVNWhdqFyFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274617; c=relaxed/simple;
	bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWWfED/2WSux7CUzR+gZYQaXpEwXKJvyQc8pETk68Kj0HGH8IBBijKvwrCyrIQCqvh01m6XDMuV2F/dD5VULCzNzYv2Ki0p+uitl+gO+TtXfoeln33YvGTQyEIRtOy6UbIPmw7ZzfMiXCkjcCCIqOuzKXp+5EkqNtNTVx58J3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+i68S5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
	b=C+i68S5alGFqUp/oSmO0vElMnerPRWOTFbr+K+7LxwhC1bWtdlgeAD34UuJAESiRDOWIcm
	TZBKtdR+PeFrYLuGqc7jzv+7UrxwjfFPmvmUqpjpZykxoKKPBQ/y8qAntvG9FszWUhijEx
	urZ9eZy5sEPf4eQqRHxgm/GzE7HMc2U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-h6EL3GFtNhmX5mgiZReQLw-1; Fri, 19 Sep 2025 05:36:53 -0400
X-MC-Unique: h6EL3GFtNhmX5mgiZReQLw-1
X-Mimecast-MFC-AGG-ID: h6EL3GFtNhmX5mgiZReQLw_1758274612
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-733ff1a73dcso34681337b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758274612; x=1758879412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
        b=XPtwO3Iy3Wci1VzwDv+a9Dqv5/GOJzbmFRt/2wR9Jh6zhtwxWDhfhtsmtlTWskZMQV
         nI6l/80OmU53GqY16fArTh/iH2hsO5dP2RUl4S8P5RdIjmzoAClNpy7tjV/KRpcBYHOQ
         SlCCfgExJrv8bmksN7XXDvo5+yUEdpaum5elh2KqiiOzH8LAl0YuRaLel1VBmn3fUnCD
         e3V24UF+skPraKdIlYoCfvgCREtSxLANFexTGNgbflBR63qVt0Ea7eonFdX7oNEvCb//
         ijv2j5b6lpglIy0wSy9gYvUoYHGCFIyPxbATEhmnI3rDMOMtKWR7m0OprKtcy4nVPZ5d
         z8cg==
X-Forwarded-Encrypted: i=1; AJvYcCWttBQi+RzdVUDX/6ITWCHrxqZIICwpoClxUQ1g/kjLGGlESIn3hnFw1cvhA2kqUFcviZZvDCxfylTi37g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yF9tAqredsTlaiLW4utb0I9n51c1Zm+6lWnIm8SF0azMZt/R
	S2TL5frThXDfwLeHS+GtGCPwCJdVcnwpwToMGEXBMUqVXoE4Eh1gNW5JhZaSmcQd/dBdYBYcRq+
	bGrxhFZl6glVg07llWu0syMO6p7ncEr3Q9q7VkhZ+WdH9qQOeghOxFNZoU/ZbDK3rYjhDrkQSY8
	klcZ6PSqsRczlu3NsiUAmHmBUQsh3/tNs7S1HN5AG9ttQERd0lUDw=
X-Gm-Gg: ASbGncsiLE7HNjaT2nfUs5UF9g+RELR78qZrVMLkZptPWbgmJNknO0Iz4enXFUk61Aq
	fog9bReHhkfFc7azMllPFZ/l+Rq6NXvKnmAaXa4I6u2FLcZ1h0Dx+zMt9GZT7YGmMzzeDYra0gY
	lPG/mWRjO4/nw9kkrllOBbhskDt+FXiUHHgziruOyRDjdLhQkhfRuezWSgizXoD1FUm9L25WKJY
	hxe8f/+
X-Received: by 2002:a05:690c:690f:b0:737:6973:fca8 with SMTP id 00721157ae682-73d3e2a15cdmr22403227b3.51.1758274612331;
        Fri, 19 Sep 2025 02:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPKXVRQHM5BX6WlYQ2cBNEMEDhW1rNSC30sedm/I330JAJc5f9vDousTwUFG5/BlT/57DXfjYaIWiVnMmx4Q=
X-Received: by 2002:a05:690c:690f:b0:737:6973:fca8 with SMTP id
 00721157ae682-73d3e2a15cdmr22403137b3.51.1758274611905; Fri, 19 Sep 2025
 02:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919093231.960393-1-eperezma@redhat.com>
In-Reply-To: <20250919093231.960393-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Sep 2025 11:36:15 +0200
X-Gm-Features: AS18NWBUmghOHNLPQI_96FL6YYrZHCEaA7Y_8tydnZj0vxyJbupjglhz-WKCBg8
Message-ID: <CAJaqyWcymm-O+ED2veDojVhcH1pAnekYLnYXe_P-9VA3rOcuQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add multiple address spaces support to VDUSE
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, jasowang@redhat.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>

[...]

Sorry I hit Ctrl-C in the wrong terminal, so this series lacks the
final patches.


