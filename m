Return-Path: <linux-kernel+bounces-860434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8CBF01E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0C094F2026
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FC2EE607;
	Mon, 20 Oct 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNFhdr08"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243302EDD7D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951630; cv=none; b=Tpf8haZwNQmoooEWK4a4Bu9YndCuY6S/+LDALGmSNbz9fbtMXEcQCuvYAWv6WxBD0FtifDtHvG74tRVz1qZHlQUCQCSXJvddKurL5CCuu4hZ3+UoUzyA2VTd0/vXhK0snVePAAHvXvbGB0litwh4JYZXdfwL72skeN1LJqdIVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951630; c=relaxed/simple;
	bh=m9FBJRe+X2p520OLNRjPn0r024IuJutRGG32v453ZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+uQG6zdqq6GfOGVXBXOX/eb0w4xSaCqB2hTUcr/0LrTGMHwFwHtP8PqTccOJchK7ikLMx+QJa76pxEIYwueW8VRXDlJ57/bfuPRcW6Ix5sb9/ht+RRQru925B5ApCEadfyqufIr9UADooCy/9YDTZllmvL5PDYYxSY7qYfxcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNFhdr08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CiY+AxGaAwH8cinDk/I+N1xFA7FzK3pYWDF3DVwTBM=;
	b=aNFhdr08rtEovoFYEO/iSBHXUKC+Gr5AOizJMMhjj/cpRQ7ICuUyODgpEa9Lfq9QPDe7q7
	hBeM2V9NvtAZAYms2UXjz8APeubt0awKZedL0ikeSV6d1J1QPTF43r6MgNue5BCTfCKMiU
	U0eueW/9le//s8TRvguV8QJUMTKbq6I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-b3RaQtr0MHy-qlSj-CFCkw-1; Mon, 20 Oct 2025 05:13:44 -0400
X-MC-Unique: b3RaQtr0MHy-qlSj-CFCkw-1
X-Mimecast-MFC-AGG-ID: b3RaQtr0MHy-qlSj-CFCkw_1760951623
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so1938671f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951622; x=1761556422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CiY+AxGaAwH8cinDk/I+N1xFA7FzK3pYWDF3DVwTBM=;
        b=NZ6HmriFvxqcVoetltfjSUBSlbbEFKW75VAlA8YCIiKzq0ZVTOEb/riVgPcpKrS4aH
         v6zni/MzyISfFABIVNjJB9kK681m4ICMs3J5HApC3AP1oA898fUEUxukzZ4AZLEchN0v
         5O/dw+vK5SANvmQJXY/HNG0lkAhaFUg8Gyca/sWzRFM1tj/+uJ4JeuP186Oxq+x3+jD8
         zbWuKxQfyQfJ7qTxcnwkVrGlMQL+jf0bJKJCdU6B9cOSMokffRmRU0FP73LIrB8qE4ta
         cmvrGLl6Dtu9UZmLpHunYlbLylEVpVWYWDGYmQ5SQYzxgZ9iB5yYvU8O15qWgyo47e3O
         s7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDaOY+xFuxQGGzqbMclxJz0uz4+tx/v4cDr24LzAu1tT8ZkO9anRkfWG4iqoS+1FmsYrEUaw4QVHJvHDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6RIqLT9idmQaLxc/lVKkGkK9OitkwtzfDObxkc2oFaY/ZjqJ
	CxGkBaYLiZAMvxcFNptWTdzew17rq2l+pSGyV+WZq+/wtxKgvd+sPhX23YIFddOp+eubnZTDTAP
	HQC+t/FKvwCwQSaFoxFkdcbLHVCbcxqMs+rg4+fok7p0+ZLdwVjwnBQ87KdjQY8eDcY8QDHOZ9w
	==
X-Gm-Gg: ASbGncvfZvoMYJZlD/QRQNsZbR6306kkjFe+0hy52OKKgOTMXHMAUsPOl6PK7eby8X5
	21ugy0TPTiozf5syG/i6ADEyGLfY9YfAbgoUHHzVHKTUbqpsioiK/eC7cmnxj1KsZhd4yo+rKL9
	Sf+tVVRl1hYEjLVwj1kHByM4L4i+BOKYwFMM1R9KmK6pt2eL8JAlaFZ0+fAogVPW6P/EAyo3did
	AamKHOeAiCICs3enuaH1m2UwQpylP8bHFpWXhZBDoAEZcBX9NTPftEReafbjuSJhnsqIAAEn0sr
	jCsOqrzOHwygmUUn/YKTJyzo3eC7mtSLLdoI4Ff4Jg3yKvOCuzYHFogzmyU898E6yAlp
X-Received: by 2002:a05:6000:4382:b0:427:5eb:c45f with SMTP id ffacd0b85a97d-42705ebc49cmr7637792f8f.41.1760951622539;
        Mon, 20 Oct 2025 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYHGkhUDnSoX6UCh31K4tPMBH5YeAEBQLQ3EcyfNpCmFCTCNtaMOPbrN7bwNaL+k5GSj1pg==
X-Received: by 2002:a05:6000:4382:b0:427:5eb:c45f with SMTP id ffacd0b85a97d-42705ebc49cmr7637766f8f.41.1760951622031;
        Mon, 20 Oct 2025 02:13:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm14662902f8f.29.2025.10.20.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:13:41 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
Message-ID: <20251020051214-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020071003.28834-20-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->packed.desc_state[last_used].total_len;


another coding style violation


