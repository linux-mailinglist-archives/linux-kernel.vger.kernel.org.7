Return-Path: <linux-kernel+bounces-828649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B4B95185
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9204B2E277A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4431E0F4;
	Tue, 23 Sep 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cla9AxSm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8B31D733
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617888; cv=none; b=Z2Xsh6237IMdaeNr1QCoxF/Q1gP+NKB3boeQ6etNvRsd0SH1xGScLQO7GuP5R1lWHkjQ/rBd2BRhZhEas7QLHAfFnssXqhTSkgt+4n4TTteJua1WjO1jlKHf41BQ1jwZzriyLmypp2n3HVdAtw0bucVB2y9OwSDumYIPrYraNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617888; c=relaxed/simple;
	bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T75nFoAIl4fGcufLaWGRhjHTReCys4Lel4TFx0feWa1VbW2c8RQzp61las8AewCauA+2b9t/WWvDe3oiQ1gN0eaRKp4NK36f4u2/U5gstjkQiH1kHlbtObGONKb2QDELQ89zokIGqtthlldCE1Kfz8e/Jw5ULcrfiocwzOjSOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cla9AxSm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758617885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
	b=cla9AxSmwvYcMyPfpl+XuZ6lXI0bmsGA4mcDBS2IQD/2STfJLDdoUG1wtrqz9xhGk+IhaG
	3f9RYH5EwgLcFFgd8AuUGI1TnEMiS7vJ3WnL4KOJJjSv7NlJnUoKi3EsEv3O58kVv1Qe/O
	crfSsVUY27Bi66ySMn9UL+VAedo1jDA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-tat1o32pNBO7IMbELfqEUg-1; Tue, 23 Sep 2025 04:58:02 -0400
X-MC-Unique: tat1o32pNBO7IMbELfqEUg-1
X-Mimecast-MFC-AGG-ID: tat1o32pNBO7IMbELfqEUg_1758617882
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-55fc0c64597so927523137.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617881; x=1759222681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
        b=czxSl7yVaPJLlnUAkJM0g/43GmwpTz6WFtgt/Mer3hqRt8PncFCLB8scTQykSfumQ2
         R4DH3iUjmTDYH9IPJaRlVHWPaE/Q12K4k66/kFtpvAWAsCppYxL3t3h8UxfUjEg6zogW
         AOv5mtIHteVQqJXSrPbmIf2l5qvyU4iB7z4Ecuwsu218r/8XXR6RFZQuQbSYMB3Dvo1L
         wlQPKQniG6amX8U6+aHVFlWDwNxXa0XRFLGUkeGVbFSbCDhS2mx5Dx4SFoTNUHMPDk8f
         57NeO3m5d8L2A5aXLh1v8ySqfWL4skGd2TtPxqr2kLEeZIaQ7fCsdwXPljyy+qk5Alhk
         Plyg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4jrOt6YKycpUXFI9mnOUxoMCcHcwVI76fORbIRWG/5I068mpNm/5gu2t1FSTQDpzeVxBVNMpBhL69nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Fpms6tmsvwz/reOYOY5qq4+gSS5HhY52Gh4FUR12R46R4zJ5
	aMZ3Bg9k0/W2qzjBCFD5JojHfKYL3PkUQnh3MIXLIBiZEkGG5EsZmsWU0r4fBjO2I8lwWJekmFV
	nebAHmsc+T3v2baTcwGw2qKBrFuYs0Qmdq6Qg7a5fG1+x2akAJ+099NNtLSBDvkeqZX8o763jS3
	VgQ3Zd3JaBfx2tbONrMv7vqFHvTfbB2gFwZInGumNT
X-Gm-Gg: ASbGnctbG7U3ifiJhncMqzRsXgJkHec6CKy/xsw72S9cKL1rCh1X2Pz/pQhKWQRZ6HU
	Y83MRDXyatJinzd0jGljTcHrCkkc30tHnaFm1p0k1tTsOINJbQTn7U4SpAwwlCrdmEpuCwGgPdP
	kjGI5/wXSoPkZcByesSDOEcg==
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id ada2fe7eead31-5a57e77391fmr588718137.2.1758617881706;
        Tue, 23 Sep 2025 01:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMg0OF+m3NO7yihYn0j1OQ6Ug6oQBHJjJXRrqGiDdaU1maoqXEtdKBL+w4PraBvKII/xnkas1KdvpyzDH3oAE=
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5a57e77391fmr588715137.2.1758617881399; Tue, 23 Sep 2025
 01:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 16:57:50 +0800
X-Gm-Features: AS18NWAdzWR_qV7nOXeqhHug2ByGphmNpVqthkSHVtEUCe1xzom7oBjU8-rRLZo
Message-ID: <CAFj5m9JW9apD56=9m2jrr7Bza_L7+DfbeP6tMZhmWjyvRuL7ow@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from
 error path
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hare@suse.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:11=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> blk_mq_free_tags() can be called after blk_mq_init_tags(), while
> tags->page_list is still not initialized, causing null-ptr-deref.
>
> Fix this problem by initializing tags->page_list at blk_mq_init_tags(),
> meanwhile, also free tags directly from error path because there is no
> srcu barrier.
>
> Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU cal=
lback")
> Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d1b079.a70a0220.1b52b.0000.GAE@goog=
le.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


