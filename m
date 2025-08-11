Return-Path: <linux-kernel+bounces-761705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59DB1FD90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF367A38AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA15256C84;
	Mon, 11 Aug 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZOUiN5S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668375B21A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754877488; cv=none; b=H7yXV0J9CUF8tJE6ezjFqRpJB/B54gUtck7MVVxge68lHuXH58f9yR98xqKbfxLxBKY7YXTXzARxYYrjjzuDjogK9c+hE4eSyiSSfIQMNwEbn4E339p8kpOjOQx31/TtXs6fQmZ1uXvNZp31EWNPkGGXMlaUQ/GVdpMhw1zCNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754877488; c=relaxed/simple;
	bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD7AkU+GJefXGbKVaBjnspksANkSwh2EjvWhV0Y9BHTqEkQx50sz2xKLT0p5DhSijskoMeSmsV5LFEqGibI2Jb1YrFp9wuPCwL3/1YLZYCpdCWh92OP0oXQYL0GsusapKXrZRTcYuS+eARnAMbtB89DlPH0ag8GrF0NFMmDmEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZOUiN5S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754877486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=;
	b=WZOUiN5S9QxyGm/oRxWKNugox7DqerSfRw0Ay3vDU3K9nRHhVXMGemfYEa1Z+CC/NStTPt
	ca30UFSe2BxG5gqc8jOfduOgJSAvJaSvSI+a0PMjCp52PCaqDiwWHa4UkvU9ErC0aHlue8
	xC5rpGI8uMy0j7v9gu8wsobV0QezUc4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-SNX2KT_kOIiBA1cw6XfC8A-1; Sun, 10 Aug 2025 21:58:04 -0400
X-MC-Unique: SNX2KT_kOIiBA1cw6XfC8A-1
X-Mimecast-MFC-AGG-ID: SNX2KT_kOIiBA1cw6XfC8A_1754877484
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0680f6270so103137611cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 18:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754877484; x=1755482284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=;
        b=VyEqPJpCUWiJ9pA0BgM4fQ8rHD2kE0xn2C4vqhg36+Ho5BqvwO8A+Lm+yDSnNshrJL
         Y+W3LqSHWR0O358t1wUuW3sO67SspLregTx2dflUx9/8HdPcce/NRV7pPCXYTAK59l/H
         LHFUuCm9R7UIKcKCyMrCp38NOXqIWZoIShxMgJd3sFuaagEfHTI5BEwPiobtzpxnAewi
         bTjY9Ez1zC6+K3qdamIZLrqyOuHdkcti/xHpTbb08B/XqeH9wbVeSRYMvXrbZT8j905G
         5CrRH9/kSHI52QsT+dzA9Hn6M/hHgTMFgGBWJ2aBlQJk78RgNXL7hrxrt4D3LbKBlKP6
         dDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPfqucOfUbOBs8lT3gQE+i7DdaLgpghJJ+buo24+eINwwis9nvHVxuHowppnsCMqLdJywx6oNxUis5WwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiFdWv2sMu4ySzkWL0e6DudcOA6MH4pKwZXZUYB7aBvC6i1Ju
	0vnexZhldG1wWXA9TlY/40quzERBjapYNVglw0a94mGVxaaAa6X58Zz4i0hZOwQ/Nj3sbKaLrnA
	LmIzeC+GNpxGPbsPAi8Xn11Tv3pENfuR0RQCI+ORzKaUnfY5mRb06QvkXweq7Z52iwPTxnNd9gV
	YhKcR7c76GjSRtwyzdU3p1QV5ZprP/Wlq+hzQAr8nP
X-Gm-Gg: ASbGncvmXI4yEwaQDvFYVX5JzXZDj0K2g5t76aLDrFiQyxN7OAd8SVCJSMpSeGtVxlD
	TDRpGX+AsS/tt0mGK3G93xRivC9/wub6qKq1rVZB5/idDSHZe5GRCEb57vYwYQk3Wgqyy3U7+k2
	/F4/itLOZ8EZFstzu63fVnovvrCE/Fz2GfU0KPXccO+SxqyefPXuHG
X-Received: by 2002:ac8:5988:0:b0:4b0:7738:6496 with SMTP id d75a77b69052e-4b0aed86229mr173763681cf.60.1754877483912;
        Sun, 10 Aug 2025 18:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQpsjqmqq6RuxtLSN64JW130ilpQcc55dHUjLQGR+sxe3gWBYutbI5uLidVi8iaaKE3hpUxvaupQrb5R7qPQ=
X-Received: by 2002:ac8:5988:0:b0:4b0:7738:6496 with SMTP id
 d75a77b69052e-4b0aed86229mr173763581cf.60.1754877483586; Sun, 10 Aug 2025
 18:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
 <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com> <68c086ce-64a0-41e7-8c95-5252dceba0b4@landley.net>
In-Reply-To: <68c086ce-64a0-41e7-8c95-5252dceba0b4@landley.net>
From: Lichen Liu <lichliu@redhat.com>
Date: Mon, 11 Aug 2025 09:57:52 +0800
X-Gm-Features: Ac12FXzAUfAnBIAIIk6KaLMx7WY-GkMs_s30M6F6RbdwVvRQPl3gAlbci-uLHB8
Message-ID: <CAPmSd0M2A7NNODWvsvu5sU85mbRVjPYam1v7pbj3tSx073w+XQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Rob Landley <rob@landley.net>
Cc: Dave Young <dyoung@redhat.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your help with testing and for answering Dave's question in detail!

Your "history time" here is fantastic and explains the reasoning
perfectly, it is very interesting and I believe it could be part of a
publication.

Based on this discussion, it seems the patch is heading in the right
direction. Please let me know if there are any other concerns.

Thanks!
Lichen


