Return-Path: <linux-kernel+bounces-830039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C80B988A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514982E45ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D9276058;
	Wed, 24 Sep 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5DD+n29"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB726F2AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698994; cv=none; b=FkwI0OnjKR02NCC5Oz62OgRcI+JEZDkI5kqlq9cbwMWE1PUZeH+RDkpD3h0WfAfWD6mVu07qZwyl9xQXd/oxqj640wSD5vbUwjaXFu20yJjoP5QZHCAHGSqfp8cbUvT6ThMBxTgavJISS1zKnfEPs8zMduSKALltACQgq4PukVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698994; c=relaxed/simple;
	bh=+ltkTg/qYuz12Npm1+IkSO1GP/vwhIlTbRT4zcfie0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnPl7EuM9AUiBkK4dS5oULNAOW1vEyhT0cejk3TA4ATW1vAALm3W+gGTfcItO+l6ObPFjYL4DuyXlyhCoKVwcEdQp+OlnVqM87i39Ux54hHfNxfgCxnOE30oXtix8leMo0NKZi1ReztVHY9bbX8aupovtDniEpfN/wgbeGik8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5DD+n29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758698989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k97RPLu4lhetxoSMAV6Rjn5/VeR9VdPfkMhWA4K+Jy4=;
	b=S5DD+n29hKDSItzKn7yvAinuu2+9Rh/+oXmuVzIPIkV0AV0ucisyDZ4el4yq5fzEyOJv6j
	5+5Cbj4dzO/wMvnu64MRY+VH07Q/NdXLURS6BZgVLnYwEsWMhcyjVDAvFtOFv+PnHXwPOF
	yPM4isa6BVmyvTSMKA9GmhWOvRc2vPE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-LDuR0nfQNmutcwT31bFtzQ-1; Wed, 24 Sep 2025 03:29:48 -0400
X-MC-Unique: LDuR0nfQNmutcwT31bFtzQ-1
X-Mimecast-MFC-AGG-ID: LDuR0nfQNmutcwT31bFtzQ_1758698987
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so5938762a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698987; x=1759303787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k97RPLu4lhetxoSMAV6Rjn5/VeR9VdPfkMhWA4K+Jy4=;
        b=dlnk/HJxPtWFv/h5q4hsT8ejtsIJCUVs8u54KOERyPWO4hg5QwLUNKwnBqmN2D9+JV
         xcu6nBzV67PpX33fi2MPQQEZmlv2qYTFN1uQ/xGmKd57HDqVr67IMTzjggjEbs3nG+uC
         EvdvR6htt/u4yyqypOiFpCm/9Cx3qHqjpbqs9u4a+HksrJg+xlwz6Fb8Ny9q9gnA1TUZ
         pnoRkSFFRWnha7MczMp3YiUIeMjRVoZLXhG1fu8UMTjndxDdyNkCFg+b1c/BSGENtbui
         OI5REKe3svmX91P39hWDLXwsq2KzlK+WXeSdWvuMXrwDyd6tdXSfySHeufvqBZ6N+9Zg
         o3sQ==
X-Gm-Message-State: AOJu0YyZaF/OLhMYdYnql8FCaO65cGV9sWCcCxDI0bUBzb5nbeb6EE79
	KSgiTigfi9sx0cCmJNXhfEHwJvmZBanB3Ezvu0BqWyadz0BnfSLk+zQwEZogLsB/3L3ubQm28FZ
	TMQ1/QBbOntHqRS4CIdImGFzPRuB/c4gZLScAsUIQqqEhr039ebqaXLF+GVAe98bPHdhOJGZ1r1
	IRThER7NfzTTcCm1zBkoMgP6gg5JGGsxuIz2e1BMoK
X-Gm-Gg: ASbGncsLeJpI+AffeVKLY+ucSXZa0GpumW9thikqSB678bnCVdAnS9aksP/OMd7AWsl
	fhOgpN8Ixv2TV1jhA2tDqtpABy3lpUynMKknpkAzeRxPsYqfXT0+ypmeel4/Wh56OfjZMZd3oaB
	WdkMxQqKt/uCZVi/QI/w==
X-Received: by 2002:a17:90a:ec84:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-332a95e8f03mr5846290a91.28.1758698986993;
        Wed, 24 Sep 2025 00:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiixCjQrnd4k7/vmpHG8JajCewvZIwdVQKFhy3Yph/jz+2559GWojk5kG0BnpLkgPt+lW5N69NnocLrGW1VrY=
X-Received: by 2002:a17:90a:ec84:b0:32e:8c14:5cd2 with SMTP id
 98e67ed59e1d1-332a95e8f03mr5846271a91.28.1758698986538; Wed, 24 Sep 2025
 00:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
In-Reply-To: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 15:29:35 +0800
X-Gm-Features: AS18NWA2kZUD543CoVRumWkWdeRo9-rPqFcB1IcNJpagZJKVnA-A13nUez3lg2U
Message-ID: <CACGkMEsaHh-gM=hksgo+Ti4ppB7fP7xT1XHve1F_rxR-w5aGMQ@mail.gmail.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> We have some rather subtle code around zeroing tail entries, minimizing
> cache bouncing.  Let's put it all in one place.
>
> Doing this also reduces the text size slightly, e.g. for
> drivers/vhost/net.o
>   Before: text: 15,114 bytes
>   After: text: 15,082 bytes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


