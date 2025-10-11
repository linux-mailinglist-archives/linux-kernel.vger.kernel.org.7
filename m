Return-Path: <linux-kernel+bounces-849006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53164BCF006
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF94E2948
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E261F63FF;
	Sat, 11 Oct 2025 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cu244VOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1C85626
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160226; cv=none; b=bwefPK2w9flqa4x5oLpDQqb9M3iV4ill53Esgy5PiEcP5s1C117HTHE4RTvgW3sLmprdr9iN6R0rtN4uipiq1CFgO1k9kicObcgL/HcsjU2CFalGIHI7sCfsmanpvb6xzgf7US5GQbC52QXwd+0RzSHH+eXUf9sj2o3iCfOdBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160226; c=relaxed/simple;
	bh=aBUkfhqkF2FXz15At5kVICUeq3RCC8St33BmVukZh1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPaDZQTEa4zOlqtHOeqPNDZlPrAhNPwJNiOfxvsXg4sEv6sqrNxouXMBhxUKtCl660A2EE8Cfmo6YrGnTaDUy35TtxhWGZMhMsCkeNIi3NdXc4tE1pHBb5YOHopD1wH9HlAk86+huaCAUeSdFj1cyiimanErWLaacnMGHzv5IXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cu244VOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9ahUxVvaQvnC1KWhSfaBgnolNJznlfPGP3pBByVDSI=;
	b=cu244VOvg/oMoo1XutSOKPLWIaj7vrYwBuceLyjht9xj+8Kt3lJ6Jsx3klUkebiulEIsSX
	qa1eDnM21uA0SKIOgpi0GE/0iMyrhus10nQiVjTEBjWxscagycCzDt4w+2t702oGSsRpFy
	H4CaWLt+1ufbBXqg1YTrureXNvXo4nE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-4ot81ZrZO_WSOqvu7rODOA-1; Sat, 11 Oct 2025 01:23:41 -0400
X-MC-Unique: 4ot81ZrZO_WSOqvu7rODOA-1
X-Mimecast-MFC-AGG-ID: 4ot81ZrZO_WSOqvu7rODOA_1760160220
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befc3aso8590506a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160220; x=1760765020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9ahUxVvaQvnC1KWhSfaBgnolNJznlfPGP3pBByVDSI=;
        b=h1kQW6sCphvajOClwNaqQWe2h5HW9RDSjIC33xCc3fMUNvDl03wY4CtyUfL3Y6Tx+A
         QvIuUFi/dAFAKjQjhRv0+JkrSepjAMXoPdBgRwDGz6n0w+5Zs0TxNjRkd9zj27Om0uG1
         d4pkuECV6CDLPn+K9d/aPVHBYXDXYoZCmoEvlk9/WXW/ukFy7Ccj7/zhr5mSM4Loylt/
         9GrzeZAUWTGLsWRLMRuqag5rxROZuePDi4jv5x89zB1MdXo6xJwKJm1ow25yqy1Ij2/w
         GbNRmSYs1zMxR50F6RTkoawzto6exnNniy81OdVUUwlYBUvdwsKX6KUv37Hu7laWM0lG
         +AxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxYI0MwSjROTCBheAhwGKk7sjShgHDoV9hBomyAD5gkS5ClUgXdXoxV4m+W/TO0Usi3AkQohDEpooFM2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdd6OV3NKuz0y+Q/VfcTEv0jXtoT422Tkk9QMIplCr4Bp6i7qa
	JZof0DDbDUTOj9JEa5yAPxGMxRo7BTq2e21aol5JX1/eQCVQncEVfKEg0tk0B7Ina/lyzQwjx9e
	5B0PnZPbC3oF4/X7B1aOnIHLdLkaYYOS85zgBk/h8bYqifnkdFNH6QnvZTuxnVIefFQlmMVuK3a
	LmvKwTnzXGIlMJcJOcqM8jRvsWQqPTvKEOUms1ybNl
X-Gm-Gg: ASbGnctciENP/4FNW1pHO8Y2n7vDKum/gO21RUfcRYJW7NegqELm8X7xJxjXAqlrnp5
	aP+q7J5jDF3aplj2iUe+MyK6TlxBrvNZbcwto/RBNMrQScuj5Utb5hKkRJnyMkGAkB8zDV55Bqf
	xPTLImaaZLmZVCFpYu0Q==
X-Received: by 2002:a17:90b:1a8b:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-33b513cedb2mr21265570a91.27.1760160220582;
        Fri, 10 Oct 2025 22:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFonCugrV0VWZfxEOqbKyiNBN0Y+G9ui5Cqzo9BO6/5qduENO1T0u6bZI6SMfTGTGPNpK2gG70HnWCCu3OI+Jk=
X-Received: by 2002:a17:90b:1a8b:b0:32b:9750:10e4 with SMTP id
 98e67ed59e1d1-33b513cedb2mr21265548a91.27.1760160220195; Fri, 10 Oct 2025
 22:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-7-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:26 +0800
X-Gm-Features: AS18NWDkZxBAjbaahFJoQUZlewfFY7UAdVcjPczSWxQOvLNedkYLahq0gmAyrDA
Message-ID: <CACGkMEuXNt2XL4yEu_5NPM4YskpqHCRXRm7bDjppJsBV4WMVRw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] vduse: add vq group asid support
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
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v7:
> * Take write lock in the error path (Jason).
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


