Return-Path: <linux-kernel+bounces-829808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95CB97F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE8A19C71FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327581EA7CF;
	Wed, 24 Sep 2025 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMdhE9w5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DE1A23AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675267; cv=none; b=DaT/0iIK6bf+h4h8uHpE7iAVxm0JaUEUcXN7PeiI9/NiwliexzuvMKfrueFCtzUD/V9Fmar4u/ixxh7uETIh9v+PlBq2c9mYihBxu3w3A0Aw9aRfVnM7Yczkqq5I6wA8PhgI7U0D/WIwbuInHsIYYRCUkpDa+TLlTPt2SIPsrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675267; c=relaxed/simple;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzwyfQdD1gExvxKEw3AX0Iae/3jgHKDa7T+ZnR08nKxV3cBwKJKqjCzTF7Sz74a6fO8MSBFPtIhobulXliRmw/Bt+NXFWiEk3NvDTID7p6ejAEVLg8dVLsRl+Se3FD8tEqtZtvit7uBG7mG6CyTHj7OLSwqmp8ocN2HdZv/EjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMdhE9w5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	b=XMdhE9w5Efjgyd1eea580BE7gvBLpgXkeEqI1bi4w7dFVDRmKNqMztlt0Ijtb98oymTpkX
	OtbaUh1Xpc02ErSA+Q0p59UYJ0GffJY0MslaW1jHRbs5HjRJZGBNUU6qIOTVTTVJhbR5Vi
	1PbtNqU8pffes56fTLnA4aa4b7w/J80=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-wKZZVFGJNgqPmtQSkArz1g-1; Tue, 23 Sep 2025 20:54:22 -0400
X-MC-Unique: wKZZVFGJNgqPmtQSkArz1g-1
X-Mimecast-MFC-AGG-ID: wKZZVFGJNgqPmtQSkArz1g_1758675261
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so5036785a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675261; x=1759280061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
        b=mSys+SZvoTP3OKYYsSMKSltDlphrm27jvSq5tru5M48n8kScoKpibR39V0yzuls10a
         kn7f+iALWdYg94lo4bneW/dCctv8PPJxNBGSCqDicIsyQceFC/CSU93A1SPCfuPlMkSc
         BDqAe651erkA0lT6H3swkSarI+nRXrM/CVfg+D9InNB93cXg6QlIjxp+GNP1RaBOe8di
         yK7oOU9sMSQZWTAEVK8xGTLMRVGHXw/49WZ2lowyyvKPjF4IYWhPSk5jHDs2EoLKGpCD
         9nIqszf1N14VdLJLcebBv4SqY/9LP5267l/x2y/ZySJVn9FxBXnfhSf45bDVCYj7TDKM
         Ptaw==
X-Gm-Message-State: AOJu0YzHWT4whBoJbijAKCAar7bRFElEdBUSgs28kLIhWs69GLPa7JLl
	2t+Lx3K5krcXZ85USumPDEDu4uWspJYD71IIGBMLlC58TFMeGWk9fdgR5CkQJSLFXNBTVRGBeuA
	fpPzcC/4Ul5DDUKK0sTsQSe7MrFlLXd9/KSzXWA/TgAi+CdA0/jlJcy4Z1Dy7/TtX/fVdIj18rZ
	1M33lAJgi7OIaVNaBttsfl56S21Whltexr3uzrdGil
X-Gm-Gg: ASbGncuGhjxYw8TQTYDFGrZQtyDrUpRKyIzixNPaWa1u88/GGbKa7jVOn9jnyQALw9Y
	K7NZE/4OHDoX8P84eJND3jjvqYnHOxhcQU7NjRiOHvT1NwPJiBy9CLO2lMT9Z5IQUkVyVmIJmI5
	GvtQ98xTpyJzfSWwpGoA==
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id 98e67ed59e1d1-332a9535640mr5034836a91.13.1758675261403;
        Tue, 23 Sep 2025 17:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEfQasazQYrAqwbi0RG98kEq9UrRRqH3IBMDr3ithyqZtr8231pYip07BOxHuYxpr8+ga/tswXckGmozrzyuk=
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id
 98e67ed59e1d1-332a9535640mr5034815a91.13.1758675260992; Tue, 23 Sep 2025
 17:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
In-Reply-To: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:54:09 +0800
X-Gm-Features: AS18NWDvb7ormS481il9vCXSYhrezOtK7Oc0syIfP-2dUJUzReMkhidld3UC0C0
Message-ID: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, zhang jiao <zhangjiao2@cmss.chinamobile.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The return value of copy_to_iter can't be negative, check whether the
> copied length is equal to the requested length instead of checking for
> negative values.
>
> Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.c=
hinamobile.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


