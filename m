Return-Path: <linux-kernel+bounces-849007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7388BCF00C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A69AD4E137C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED481F4C87;
	Sat, 11 Oct 2025 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fANOq17H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FC1E3DDB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160239; cv=none; b=lYbejkWbwEUYs0EdVfxlcCzlWkRUVN9/d2rZYp/+fLRxthAlRk0yTZ4AASp4r1Fz3/zBfaTO/khCmJddeeGymtDOWRFrVpXO4xKouEcza1/Ci0hD1R94Onco099Uujczqc86gNQ227ZyNaCyh1YyA9dbHuaO2Ir+bT6pj7Zcgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160239; c=relaxed/simple;
	bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJcNuK2grgpOWCS6otZxbGQswYgmcTRwfBF0ypw3ro+dnU7e0lTwf5H0YCl5inDrbdssbXGJBN4bjgwTwHvlu/uHw+9SP+IWt+oBY9iVBg+QMgn64Qj4bfcg1EOyMGILxStfAjcLtVmqZlR2vAMhXQdBDB3BUBI9ueOUeMZKEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fANOq17H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
	b=fANOq17HOki4t+ATFi62mAV6GeKZWCSZ/m97rT6U0kMMYInpBuNisKAQK9KaFAd9d9xjZa
	fzW9aiZpOrXz0/nSlFlcuIdQ/+CpszJCnV1o6ETJLgjSYXDq1Rqv8oL+JBOKvxT6oSpIv5
	sjblsyajzHpU4p6G17MrLkZmpakPkyg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-3aKq2SdKOe6R_L15N3DunA-1; Sat, 11 Oct 2025 01:23:55 -0400
X-MC-Unique: 3aKq2SdKOe6R_L15N3DunA-1
X-Mimecast-MFC-AGG-ID: 3aKq2SdKOe6R_L15N3DunA_1760160234
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso6741304a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160234; x=1760765034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
        b=m4f2Yerv5Fx8jYD0WgHKe6McC1MO1zT8Pop037qmMymM3ajwuKUHItgCH/bh6v42VL
         nQEXKWtwVPimoR7PYprqcHyJyFLGs0JCJ1g/lM/x9s/aenCWCOtkQQ8CreBkjbuwyNkJ
         f/1HpEwYPHyF8JrwABWd3rCCxNKmnABIFu5VZcJC4zI0MRLN/tNArrqwaG3eVyEIu4hK
         EGnh1ZzZEE+/QTCantcOH4LVBRbIHLZa92uf5BDvO8LS/aW32YnBorkrUaFtSVTLqRfA
         FCEMfpMEINzMKIExKNzDrzyyGqpCup8tNyIS7sY6jWGT3DVJWeIZlOhQdqnlJmmdh6EW
         qdtg==
X-Forwarded-Encrypted: i=1; AJvYcCWg1IICdSMki9/5iwlSoN+awPQj7bVPpMzKzwvHiS/O7KYBefuKLIzVwGv+Rfr+vt5hWu3ngmG1sm/BbjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCDwwbcO1GlGhg5ehixVo3nJ4iCtt8pLNAiRAs+7ygWMf5tS0
	a1RQJ/TeLJa81SUMsDPQHW+j44aULaBGquSoUbB2d+ChZ8ygDfN8noBfVCJM9uTEqNaPVRoQuRM
	vqply2czxA/nYSeIj8sqWiqI3R477XWyrm0VorZP15UyMC1cT2HBaS2VCQWYl+l3FMrMOdkCpwK
	bG0vNTXmylR6qP+SOi/bvQkUv0MiiUaTUQhPx1147i
X-Gm-Gg: ASbGncuTsX5npTKy0n531VevLBYOBjbG7NvKWPiYcMaujSExpH0hoZdTbOIxD6YEnPg
	0iaAmAFuiOou+wYJ4pW0qsGlSi40FA5yjqeJZlRY9qYiGgDa3K+AAVb3ovV0DX1AzrqngaFmalV
	CZVvofY+awkn5bHm63OQ==
X-Received: by 2002:a17:90b:4f4e:b0:32b:6ac0:8633 with SMTP id 98e67ed59e1d1-33b51149788mr21426250a91.16.1760160234040;
        Fri, 10 Oct 2025 22:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqdXPAS2ssgsKHgD5+QnWtQ1lApDRF+iswoN8NlyEK29EMvNGRiuCBOFj30yFf8WhsUrmzk6ZCikFrT+2WxBg=
X-Received: by 2002:a17:90b:4f4e:b0:32b:6ac0:8633 with SMTP id
 98e67ed59e1d1-33b51149788mr21426235a91.16.1760160233656; Fri, 10 Oct 2025
 22:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-8-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:40 +0800
X-Gm-Features: AS18NWAGyWlLirjUfX97UwGc0J9nSt_XHJxxToD8sgbypOyWBOyMc98S03FQ6J8
Message-ID: <CACGkMEsW+v1+rzbr4k5Jpxi0JfVBTJW2R1-QYYf=_3cNFBZtWw@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:59=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


