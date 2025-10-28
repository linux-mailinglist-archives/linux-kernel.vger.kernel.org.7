Return-Path: <linux-kernel+bounces-874488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61544C16717
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B94F7B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09334F465;
	Tue, 28 Oct 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrK9+tTZ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3C1E1E12
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675616; cv=none; b=cEH7kVDwfYfDtxdul7jKdbLh33XdLNC7KTDcIHJT4vfnbioZ2DqXyHn1XQV16iAt2mdlSsk24GLBaEEcgAvWPldHD/+RIV8Ya6qIdOMeAJtbMgJFM0H/09cPsVc/vMGLdwmwhOo88giv1hThmhUX9LUn43Mf3D83xbJEkLt7V40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675616; c=relaxed/simple;
	bh=fVD8zVGoOJR8NtTaumfAAfOnBXb59cGQbZXEVlQfwd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfs20Vt9sxiNZCvObRndVMGN0dmcZrJzySUG9xZmMMouKt67UfITaegawTs9C7SqJOFQjd8fsk2Vnty/AI7Ioctl7aqr3l9atOd72byENECFqDkCCltulV+07bQo2Vm04Hqy9TPlHrAz1fcHyV113OfoGTdRgabk0PJaDMVd+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrK9+tTZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78487b0960bso67875697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675613; x=1762280413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=NrK9+tTZmtBoFdCEqOScvruet8btNL0A/WQIwbU3hkehG1AbI08JEmxsP5BfqQOX7a
         tXoYBGb0LQx2FYPOAEkfXMCw0mOebE8IrIlVM7cf8AQXDZ9bhMA9rV0iKd4UeAYyQ4aP
         H//SXIbO7HrnmBmMDGIzb/taC/32jDu1fenhChBvVpZ8orobcwRbSl+hrcD/PIxNeIsR
         S/qoVdm2HBpdwhNPNkpa+4f9JlhxenUdpY+Xn6uSZ6ntM+1byLwMShcG7SVBPQX+8mX3
         PPGEWCPJjNK7UOPWV45JBcqRK39tqroXcFYlOt47J/+TQmcUfQp5ZA49fh8g4GLIpNfZ
         FsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675613; x=1762280413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=wCpZe10tKwDmrqeavSEWntw5cN7RDUCalxNttP6V0A4J5T0ChqY7aBGEYeFfmCTgq+
         C15PhUyQoj2NaIEjBfyt5tf817vz5uw2cB557+6qM8YXYNxp5DHQKMur6suvZkhZ+Usp
         jO2Xe6mybJ2+IF4LKPC1znv7g4pudc3s3JFpSiTaBB9cZgD9cEa5FfdVrqFtgPwkBcc8
         +Nr0HU/cNBW4+elLCcvqDOKElBIW5milAi3zt1/PkTz/ycJoVNg8GvGVqJIkFcZIc6X4
         Z4ueRpCAz/QKFldMpYzjv8p9zBSgeMeO5x7bVE1AXaZgST7c97mZGnK1tEt//8YN7t4M
         savA==
X-Forwarded-Encrypted: i=1; AJvYcCXE35B2Ms9tY1LLDWiZMDpfq6K7IN4ziJXuMESB3DuVzszrYbkvGEtw//aVeCEyjjVg20zAcIZipRoy45M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv75Ez1ixYg0RqCSzvB3MKSg4QSN4Hfpe87at8Rnq1dcv9heu
	w6Bb8OnOMW4kD7e/Wqq7Tzs7B7tc5gI+d4xrtTAsg8mWRRconKVtM6Lv
X-Gm-Gg: ASbGncvLZNSaqTSDn+HcBNUzmObLJ5jCyl0qTn4Dvl4jeuPLScXNOUBRXAWCM8becBs
	H83vvAR1a03sUY2BUqT9Qyd23JBPcx3wARPiF10jbpkj4/kokI0VgVX2Vu/XRBhcqlpLUQof7UL
	UvUoUfpXrfEIeNhPnAkrtKLkikFqfqdPXzXsDivE58Ey7V7QOmNCVIm9zkfZdd4u4AbxZ/mffQz
	potC9fe9dUWAXW5L/pXgq+NAfClnHIk5BiB5eFgzOUQXNYROXx6aR/nw/OnJaK7klhyCzUdqTWC
	ElE4zXXrjmYYe4PKUCWXeX9yOIVfuZDznCDOxhPJwGFGpHfbM1LHcIfaWhUa0Fv/HF4/JKPvCov
	t7BceOm9Brjrpgg1PlNXo2yYq1CLbmL4T4p75j/b/uljIdH59NrucGOqd4EwtQsrNH+L9JQEiPs
	Wr+wiEeiI/n5tcmJm5ql3WJ+1yan5B5joGfmJa
X-Google-Smtp-Source: AGHT+IECradbC/V5zPn66y4q4ZGUhUmHrlC+iHH0inghtcGySqIEBdHH/OeoOeHNcRqi2EB+aeyQgA==
X-Received: by 2002:a05:690c:25c3:b0:783:7081:c48a with SMTP id 00721157ae682-78628e7d68emr2711617b3.26.1761675613298;
        Tue, 28 Oct 2025 11:20:13 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed14081dsm29213987b3.6.2025.10.28.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:20:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:20:11 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQEJW9hGIPbWsRhM@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <20251027162244.0101a099@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027162244.0101a099@kernel.org>

On Mon, Oct 27, 2025 at 04:22:44PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 12:08:48 -0700 Bobby Eshleman wrote:
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> > 
> > I also see that SC2317 has many other false positives elsewhere in the
> > file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
> > unreachable. I wonder if we should add a patch to this series to disable
> > this check at the file-level?
> 
> Yes, FWIW, don't hesitate to disable things at the file level.
> We should probably revisit which of the checks need to be disabled
> globally. But file level is also useful for manual testing.

Got it, will do!

Thanks,
Bobby

