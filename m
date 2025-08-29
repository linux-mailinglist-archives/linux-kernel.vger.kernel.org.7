Return-Path: <linux-kernel+bounces-792098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E051FB3C024
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830F93A2C35
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C75207A0B;
	Fri, 29 Aug 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+kKbdxn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAB3A1DB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483327; cv=none; b=j2MqmOXPFRTKsW7GTMeBrC8c6QyMwmlHlYWD7ocZzC3zkwRumvtrQuTrTeWYG4BLF1bBfpgBmFqc85M3TCKd4EZKxGMDOZSC/E2ONZ9ATfRhRAOE6SA7Loh2p7iY2cON+ANxXVjucc3/3ENt4OoWp8mjE/LFs7EbE2oVMSJCYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483327; c=relaxed/simple;
	bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azScFhu/blqSH2iHNUtPnfwJm29F9Ncg8x41mtSpgkvQbNLZBmueh7PFdjHGVGf5bON1tnJD82EDP2c89ozp3Es4pzEzqAJqY02Bldg4X4NWJTU2U2uyxC8hoqpl19IZnpJpv5Rc2RrLphtRlDHu7kCOwfWtxpsJ4QXqK4oxF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+kKbdxn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756483325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
	b=N+kKbdxnMCCNzaJLc793+HGDXQgmHf7+OX9odtdDvZ3HNVjPC5PpoUAQH+uf8abyM4TuNx
	dtjq7SQq5iFu8qTNF7SzubQ04XSsMWNpKwLO6IjQ9Ixj61SD1PUbh8S9xzPcvPhjbzlBzj
	L/Vc+Ahc5+jcV9I9cTYlJH9IiGlyXz0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-PHam4YGZM7Cnz32Ps7vCHg-1; Fri, 29 Aug 2025 12:02:03 -0400
X-MC-Unique: PHam4YGZM7Cnz32Ps7vCHg-1
X-Mimecast-MFC-AGG-ID: PHam4YGZM7Cnz32Ps7vCHg_1756483322
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3366eebaf61so8864081fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483321; x=1757088121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
        b=vGa054CZWule9scVMQgbxI4MGYrI6RCNQxI/I1bFj2KOZLI2PQciYHUCRjeeRlHV6B
         n15VrvCms6gwv/TxmhjpOou2oz3Nmk/beiHJ96D0Egbo0psvtiX4jKLIhVOIZN1UOzeT
         ElLdZ7F7HJSYh3kGsjjJma26bfiN8KW0LEDN9nmZgxE2DWXB9aUb3Sb+7TJM1V9MydTw
         sdX09LV5VaRkSTGd7AVEp7tbl/qXkf+cfIA6cM/cNhmnT5RDtrI3k8JnLTiQ0C/YkN7e
         hvfwKGE15vyBFTvjihvN22ikalD0gSB6/HwFzXuepJjFlu8EX7HcmQSSsfBR96UK9AdQ
         KBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNGNNbngsHMte0JoZPTG+ztxDG9O52zlzvAdwVa+HLlPzPIKAEWEWeOe5BBFUjVxp/BC0RvWOTp95Wf2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdNzvy8pv/Akca1Tw/YiKV6Wom9PHGdvrPaOXU08Z1WxVlSok
	LRIaaPR98SSCctTlqilxlULDNFPon7Q+fe+gZ9oPryO7El9euzsVKWAAFZCiHTRvZINfE96FBQ0
	Mk9IWZb0+O/QLtqiid3uRw53rpOPRBK9IlCouuxpKWcOMLBEXvwWMwE+uZ1w0GS/k2qW2sGWGXG
	BScbVNA9uKwPSoxU2UFdWC43m+LpcE5tuny+wlnaNr
X-Gm-Gg: ASbGncuAiok5QXBCKoQI5Y+Cu/Rh9ogf9CT4ILMaNyuEOs0zRldurz9HFKKg/GgAiRe
	4zXaN9kwLuuIAqaPU8mNU7SpO7irYx9yd938aDdnWvZ8NWRcvhVIjH/1BMEYSnAIIui3rJ6QzXJ
	EnwAGVKeG84KXJUQg9qhiXxGiYXzPNg0MujhPlrnpneIG5xEpB9tFc6cc=
X-Received: by 2002:a2e:b8c3:0:b0:336:8abb:6b31 with SMTP id 38308e7fff4ca-3368abb724cmr38056411fa.37.1756483321563;
        Fri, 29 Aug 2025 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwdtjaXP/iAFYrrsuLxUME+VeuCvN+pts+ipwS44SmoVvgLD5S+SyEfH9GpXO1F5UEojfC3BVozRpTE+XK+gI=
X-Received: by 2002:a2e:b8c3:0:b0:336:8abb:6b31 with SMTP id
 38308e7fff4ca-3368abb724cmr38056341fa.37.1756483321025; Fri, 29 Aug 2025
 09:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
 <CAK-6q+js0y9Pnubg0ev3_GXs8Fa4KYU=nNP5r=FBatuEAUhJkw@mail.gmail.com> <CACsb0NhQ8BBzcUtR0awMu6AbP-xwLvkUotDAAg-LbUV_LxwiNA@mail.gmail.com>
In-Reply-To: <CACsb0NhQ8BBzcUtR0awMu6AbP-xwLvkUotDAAg-LbUV_LxwiNA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 Aug 2025 12:01:49 -0400
X-Gm-Features: Ac12FXyDNPnEIkw_zWHS9CIL2QNCOairrzWrDiqSNWN-KcBqAA3hSzD-8--90gI
Message-ID: <CAK-6q+gQOQsg5uE2-KioKBip5agCV5AjhXbxgwqngvg8ct=vVQ@mail.gmail.com>
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock messages
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 29, 2025 at 10:35=E2=80=AFAM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
>
> Hey there.
>
> This fix tackles a tricky race condition that can pop up when an unlock o=
r cancel operation is triggered while a deferred lock message is still bein=
g processed. What this patch does is make sure these operations are handled=
 safely, even if the lock is still being resolved through dlm_master_lookup=
.
>
> The problem I ran into was that, under certain timing scenarios, a lock c=
ould be canceled or unlocked while the deferred message was still pending.

depends on how your lock usage might be pretty normal. What exactly is
a "deferred lock message" here?

> This could lead to an inconsistent state or even accessing freed structur=
es.

Do you have any reproducer or more information e.g. stacktrace for
that with a debug kernel?

- Alex


