Return-Path: <linux-kernel+bounces-807616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632AB4A6EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A017DA06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1D27C162;
	Tue,  9 Sep 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj78dqPw"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1B27BF85
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409054; cv=none; b=EnVS/Vp0hdc9iG6FciqvTJP37/TjoJpIb9+DIqQpgP6zg5lhnpvvIFHspjPcW5MR83qpVaGc2R9pz1cbh+Wq2Nrbj/AXmMeFZ3+044C0TJodnCnxokLfLHMu46Fet/Hk1MbdLQ9PfNWT0TIyNEHkwaPNfSm+expGlkwwm5PV3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409054; c=relaxed/simple;
	bh=o95+cfa5sUZFyYFwQyCqEETEg6nJdd6D0ITPZ9shB94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGeClDRIJEXPv5eREriULRt7z51SooIcvadyGdvm/BYe+93QwYqWmgwt1jKMLXwuB4p/AZJlFmHNJK6KMXxq6IfzmIYY8p23Zu8dMoAKIlENQGBDL1X0FZ4l5MtqvIzjeiLdN80IbTU3BP+G2NRdFVukdn4Iz0ztGLLEFkEvlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj78dqPw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7722c8d2694so4535368b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409052; x=1758013852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrZUr9P7TcE3YFVIZvDzSstHd9MmX3+aTHo5NK6edbE=;
        b=Wj78dqPwRyr0HwALux+OVkjdq0B/xIywmrvX9+NR2tuZr6QdfuwfuWClEXKT/TrCdQ
         uaSr9z+AiUb0TXbXiNWvGAMYVmWN57ei2j+AygSAyrh1SnWqUp6//NEtD3i+Ixouam+J
         sM5XrJGHZOLfH29qmi3ptlvd6v33LSKuDmXa/0zPfz93tMLZrBl8TPGYaG2WZKsgD01E
         Br9AVltVzxNB2+JzHmkrvx6GjQxMa1Lu6vfBdXkIyDdNyn+e1r5rbT3CRthL1gn03pDj
         wjvDN+eJO44JSDEgX+pjuQEDfMi/ECXPt/1UNTXMYu7WtMFKzMBkbsjFX7ilwROZYgGY
         G9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409052; x=1758013852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrZUr9P7TcE3YFVIZvDzSstHd9MmX3+aTHo5NK6edbE=;
        b=nxa74ZGB5F2GuzBGcSZ3y08oE0ruftRMczeKbHf/4/NDwv/64XE11yT5HYrX1ovmqm
         ifO7L5zq7epaNSSBzBGIufKKEUKp9LnJ7QvSiuTO2jkZdpQ9UCc8WxZlyiKA6s6aTYcc
         5/h4RYrgOVu4w0mqxqmiXautJraXngcOKNpg/Qs+Q/IvKNiKH5XlhBh/DquEc3PTK1dX
         YxmXHwJEg6UTc1MKtquqvnnMoGGfieHZ0DRvQW3vSlJaDYeCs4/XzLM7ig7TzwyHHI/m
         gCXOPngFpkjo/s3/7uW5db7R8b1FRxicPfNiFmhRio3TC0GFuHkVCUNLDhvdG/qkFeQc
         OSLw==
X-Forwarded-Encrypted: i=1; AJvYcCWjhlsCNpTnaJPziBmVuyehpRpIU181qKXkblq9WXj8JTVb/s3fIXsjmADZziR+MAnuR1g0jEQdtivpMOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmDffuMkMJ8JPjjfuwROhBwTfVvna2cA6LTNyNDEBYDuhlEDr
	22i8xzolGjHLx83HLzcoTupPXGXOwv88hIHwbqmsI40wJ93HW5nga8NW
X-Gm-Gg: ASbGnctbygca54x5c+qKMlrK6dYocYZDD7HpUipiPnMBtZ+84cSz/Zhlogb6Ats0vqt
	2eAo9MhxUNIWLVD0wky08Z+AzXgAUzVyBH8cdM6pbhXHuCb4YYksDM6KlHCCLKIHb1O3RDamsqS
	dX6+9FZ36oDN3YFTAUuVTpx/q+sq06uVpe4SJRQhe5nx2LYDiF21GH7uWY0WbTrkoFlJKtM1c7x
	d9eR0s+s6XqnieKPpBCG+vHtPmrZAzQaYNvuGoLcD4DVKXXp44DHKFtw5/RIS2Hc85a3erROU2s
	F4XTiOtw+sLd/0cTf/AjIC8k61/3+aJjU964wWR143QUlZwyNI/db45p3GmvGF3ndm+jkbu1L9C
	JXjSW++p4uR8iukGXZqbaUA42LQ8pmN3bDBydDrIfngaXTAmvrMAC+efFq77X
X-Google-Smtp-Source: AGHT+IG55otu4hEX5eJB5CsZDymIFIL4KDTOYyBrId2Avk8r9GKQj3jKXMv0L2jkldFhnG9/lPdGGA==
X-Received: by 2002:a05:6a00:84c:b0:772:3f03:f3f4 with SMTP id d2e1a72fcca58-7742dd52bfcmr14841662b3a.14.1757409052123;
        Tue, 09 Sep 2025 02:10:52 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774661247cdsm1448905b3a.33.2025.09.09.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:10:51 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:10:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
	sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
	Aurabindo Pillai <Aurabindo.Pillai@amd.com>, zaeem.mohamed@amd.com,
	wenjing.liu@amd.com, chiahsuan.chung@amd.com,
	Natanel.Roizenman@amd.com, Daniel.Sa@amd.com,
	jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: Optimize remove_duplicates() from
 O(N^2) to O(N)
Message-ID: <aL/vF2Q075yTzUqP@visitorckw-System-Product-Name>
References: <20250824182359.142050-1-visitorckw@gmail.com>
 <20250824182359.142050-3-visitorckw@gmail.com>
 <0ed3fa16-9e0d-4f8d-ac22-c9f6b541ae8b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed3fa16-9e0d-4f8d-ac22-c9f6b541ae8b@amd.com>

On Mon, Sep 08, 2025 at 11:10:30AM -0600, Alex Hung wrote:
> 
> 
> On 8/24/25 12:23, Kuan-Wei Chiu wrote:
> > Replace the previous O(N^2) implementation of remove_duplicates() in
> > with a O(N) version using a fast/slow pointer approach. The new version
> > keeps only the first occurrence of each element and compacts the array
> > in place, improving efficiency without changing functionality.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Verified correctness using the following simple unit test:
> > 
> > double arr1[] = {1,1,2,2,3}; int size1=5;
> > remove_duplicates(arr1,&size1);
> > assert(size1==3 && arr1[0]==1 && arr1[1]==2 && arr1[2]==3);
> > 
> > double arr2[] = {1,2,3}; int size2=3;
> > remove_duplicates(arr2,&size2);
> > assert(size2==3 && arr2[0]==1 && arr2[1]==2 && arr2[2]==3);
> > 
> > double arr3[] = {5,5,5,5}; int size3=4;
> > remove_duplicates(arr3,&size3);
> > assert(size3==1 && arr3[0]==5);
> > 
> > double arr4[] = {}; int size4=0;
> > remove_duplicates(arr4,&size4);
> > assert(size4==0);
> > 
> >   .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> > index 2b13a5e88917..5100e0e7af42 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> > @@ -50,18 +50,16 @@ static void set_reserved_time_on_all_planes_with_stream_index(struct display_con
> >   static void remove_duplicates(double *list_a, int *list_a_size)
> >   {
> > -	int cur_element = 0;
> > -	// For all elements b[i] in list_b[]
> > -	while (cur_element < *list_a_size - 1) {
> > -		if (list_a[cur_element] == list_a[cur_element + 1]) {
> > -			for (int j = cur_element + 1; j < *list_a_size - 1; j++) {
> > -				list_a[j] = list_a[j + 1];
> > -			}
> > -			*list_a_size = *list_a_size - 1;
> > -		} else {
> > -			cur_element++;
> > +	int j = 0;
> > +
> > +	for (int i = 1; i < *list_a_size; i++) {
> > +		if (list_a[j] != list_a[i]) {
> > +			j++;
> > +			list_a[j] = list_a[i];
> >   		}
> >   	}
> > +
> > +	*list_a_size = j + 1;
> 
> A corner case needs fixing:
> 
> When input *list_a_size is zero, it will be updated to 1, unlike the
> original code. Maybe a early return when *list_a_size is zero?
> 
I noticed this issue while running my simple unit test.
I forgot to squash the fixup patch before submitting.
Sorry about that.
I'll send a v2 shortly.

Regards,
Kuan-Wei

> Hi Aurabindo,
> 
> Do you have other comments or other concerns?
> 
> 
> >   }
> >   static bool increase_mpc_combine_factor(unsigned int *mpc_combine_factor, unsigned int limit)
> 

