Return-Path: <linux-kernel+bounces-819150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F2B59C22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DD17B227D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252D35A29A;
	Tue, 16 Sep 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUwD1OjX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE066352FC4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036852; cv=none; b=LilUesXR/GYdeUH2yc3s/VCzFn6PVxkyGYDVsWg5CKnuOGvpqTt6kF3aaEOKWCm/aOQP+6qiwR3wVfLiAejguuLQNwqADI7R9jNaDnTqrJOw7lsoDKlB1yQEPt0WJVBj898/PT3L8ze//xzanaeqOAfsi8GWFJpB8e1v8XFPcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036852; c=relaxed/simple;
	bh=fxogLSX94O8l/HI6sQTt4qrfvYwwdyP6SUZnBgnQffY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myvt4gCQRLPizpbSQdsRX3GjG1w0oKi+haqWEcTxoiTskRJPpIc//1tMbgxi0HRhuvpMz1SxUTYqnTeUztr1XycYT7pLP5iBT/LbmWZLyvk9YciaVH2iKS6C/cZFlE5ZsVy0+JgXzpSQuPuhITTAmJQ0GMyHMZLaREVItsrnPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUwD1OjX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so5175501e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036849; x=1758641649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z4miNrnhZPycrO3g5GYcNPXzP3TAxx99+7B000zkcI=;
        b=aUwD1OjX6YiPrf0UX0JnusyYMQICectjVsx8oJ+IsfnLk2gpUVcrVCXBkO8TIsQGza
         9bmtXPcKe8p7F8T3AqblSomHgt8T6ti+40+aJvHBpUViFd4euBrt3ypx9ujPFndPB+cc
         67CqW38vPruEMs42auwnJKXVUw0ulEoNcEz5JfezDImHZH1NJNiGww0Qk66wWWTqOAUK
         H1ao4LKxBFNf8Xiv3mcRFd4nl/2zfZ/dgbk064F1WrreDgYf4zptIrHF0ZY9esXfUSLN
         rIoYcsuv5WazhFDQ/3iH2ISRSD4Lq2zrtegrhxzg2T9SXkTi63FlqGWkToFXXFXL2109
         tHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036849; x=1758641649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z4miNrnhZPycrO3g5GYcNPXzP3TAxx99+7B000zkcI=;
        b=B3w+2hiAi6OL3lESPk/cirjjzM3hlIKXVxwf/D5SPpRmk8YroeIhPvR9d7G7S6KQa3
         kp2UELJ+5cRoWMTbztGAtsWR0kCEjUtnnsG/bvCn9zj6RHrsRGZ3Jw12m6UqRLsUTFIC
         YG3uoVo962JEXMyMnQpTe9YOHtORPX3CFpd20Rc7qL0majGjEbMTOSA4izGa65Garuxm
         gGRmfMPDWqjgPIZfsLmqTerVVwxu/1A9yrgQiqqJhzh40BEdRbFHENtluvk5RiMw6jeP
         WtdkVQIbCF+M0T7Kv8KLknvSApL41R4yTP+OcmqbOXcaFNnG8Au7DFbks7O5PdVTcaoi
         D09w==
X-Forwarded-Encrypted: i=1; AJvYcCVCyDiKjJJ7VUmyQ8nlfCh3QtJmNGdTR2Zr2/fhBptEurtolbbkHyAbXHWXYLrXCyjVHk6VN9kQ/+WtRG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIzgYl3uY9G3WqaB1Vb49lxOiffoebYm9kzXk9HUGkzhDUj/i
	XaVCaY8JNV1QChrLdKmxWD6cl+PToedSQ5UgYumAYp17OBd06BpJnRIh
X-Gm-Gg: ASbGncuDZwzfAL267UI1xseNQStgLeWwJq9LXl173zPftOOdSRaUDnpRB/fwkZzaWHM
	55+I34UMH4qK51anYC9Pej19WxObaJHa7MC/YJwUYanf4JT7zzhNP3aOvbLrTehwS09JnxWjU5Z
	+zf1E1O4NTrinPcHw8XHMc1a/SySK04cjzsXhNAMkHocbLRPyJ9beFaos+hj3Po/Z9t6M4AapGr
	GxIqo8gug/1zR9QBfsBxzOg/+D0qREt4XtSU5a3KbZ4eWvDgTGgWtBvlqdFB9RkmG6fiFI8glMC
	UnyOmnRTUFEm+2eF5pfy4DBO8Oa54hd8LVJMWaLjGL9Ag7Kq0+FWgnjcPKZ9u/pWcA==
X-Google-Smtp-Source: AGHT+IGTaHnDatRG5zbicey/YhcGq7IWpIBYMJaruSO2Gk0m50zZsKryEJcShBMjgdMFvEhIKPMQdA==
X-Received: by 2002:a05:6512:681b:b0:570:b85:fb8 with SMTP id 2adb3069b0e04-5704f1cdc3bmr4166584e87.27.1758036848582;
        Tue, 16 Sep 2025 08:34:08 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571d16e79d0sm3199279e87.86.2025.09.16.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:34:07 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 16 Sep 2025 17:34:06 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aMmDbgozQxcNyNMC@milan>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-11-urezki@gmail.com>
 <aMhJHUfr_PupSZSW@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMhJHUfr_PupSZSW@tiehlicka>

On Mon, Sep 15, 2025 at 07:13:01PM +0200, Michal Hocko wrote:
> On Mon 15-09-25 15:40:40, Uladzislau Rezki wrote:
> > __vmalloc() function now supports non-blocking flags such as
> > GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> I would just fold this into the patch which adds the support. We also
> need kvmalloc doc update.
> Anyway
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
Thank you. Applied.

--
Uladzislau Rezki

