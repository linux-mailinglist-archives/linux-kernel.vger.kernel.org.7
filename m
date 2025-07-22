Return-Path: <linux-kernel+bounces-741030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D599B0DF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6150D16F715
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9542EAB82;
	Tue, 22 Jul 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwEQ2d26"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1202E9EB9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195202; cv=none; b=R865qiXDFZTZhkOPiycjMaZ7NE+uNaerWjoDg50i4udpAZXNVpw3fcHZ71Y7f7pkQjZIr9ojICJf6Jmsj6szZ8t78udZGMYM4gQAzI7hQHOO6KkAyl65tp4kSSoZ0jm56RQcqsRuJcKJyKr9wkW0OCvJR30LY0plCNMhaZPiQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195202; c=relaxed/simple;
	bh=UUXfcJXt3yUtERWhIkgUGnNxGAtGAIrftLIQwcp3snI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lElMgZHGXN7aUjKpeqSspiQqdheATWoHHFTR8Cx3l6SCXrMhSHtWIuICB6vX5KXyqMoPj6buUnd6B5fv5Wg4+g66/1iXXFkPix19TYNgZhSbiCP9mKZKllngNE7YujFwXV45IT8qt1Xf3NGJInZkDzNAMQwEOlcRKbSsyNg69nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwEQ2d26; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753195200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUXfcJXt3yUtERWhIkgUGnNxGAtGAIrftLIQwcp3snI=;
	b=NwEQ2d2603n1kO0nWRXDwtfM3Zv68JlEUQSAMPL0e+aNTqD6yfcG1Ui//KbynhhBPszJiW
	CeR/GR8iG41gbOf7qsAS/VoDy8yYkcasDvdDYqB7loqMV9BHcp4+O1LhCU8EWxMS8Q5jAx
	TCNWomI9SD1cjZNmr36Co2xm825c3gA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-A7eLqB84MzikVJTf4aBwKA-1; Tue, 22 Jul 2025 10:39:53 -0400
X-MC-Unique: A7eLqB84MzikVJTf4aBwKA-1
X-Mimecast-MFC-AGG-ID: A7eLqB84MzikVJTf4aBwKA_1753195192
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso49937815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195192; x=1753799992;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUXfcJXt3yUtERWhIkgUGnNxGAtGAIrftLIQwcp3snI=;
        b=niwhFWP7rHKnzmLOYh980W/PrwMDcOGD7d4SMbnW3hyHogaIVtjI2Izt8uUW1JouJ6
         aTre7nwosQK0I0kjV680gxr3RAgN43lRAxK0bfnkfifb0gSk0eJRSXYn9HBme7/Hl+kJ
         RbBHUgIQcKzQoZ202Y/3cji7klQDqlgFPuYYKKKt+h7ufSmhvLT75ftM6t29Rb/Vdp5c
         jgvk3C8PZvQ9L1DoSi4U6fZ26qYVbg4x3t6GxJOqrtBlV6iSuW2wuRoIKAgIObd+AFf8
         DlhPR5pGPO9E9jt2NxbnEpKd/cWhFI4czengudOYIKKu3xACwnFPydCfKaqoWZnbnePt
         fegQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9GV9o32mNVlvq6+RoUYiAYRWpmJ/rL2NM2uG68rc5xPIOykrrFuzazairGXFvF+q04T5PjKvKF1yUCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6UNoKaQZP5Wr8EA70bSL0SZ1Jebdz8/HRKEebjalnwtcJvsn
	/ZiQAdYsxiYwHbmojqApI/4lSQ02ISBpg6qUpLC/EexpvM/tyPEIDGBagX2rjVTBSONk7kfkFcx
	2I6RNh08yDfWE0FxrscTM/uJes/aCBPlWoiFdRFyb/CpE5adUByegeRivNhMcBYLRoA==
X-Gm-Gg: ASbGncsFG8zi3jsXglMH0y/zEpBzIipdnhRLiGR+2eXmSSkMUzu1ERGrYaO8NANmFQv
	dit9pZVADek8AUueiWU6nVCddfYxD+uhNsCErYYCdBCuWHaSDpnlhgWtf+V75n0CQ9P0A5cZiEA
	gfppmy2ifBLMjAfd/T48lawtNDGrx5x2H3Yo+RFq0VYqXY9g9Xfv80ZZhd4nJuZqwkIOh/EgQaE
	xaLOpyGHRIX5w/3ZBb+SIM1pxsPcfquwoRtJ1SKaE9DSn4KzhV5rriku74piJKweEjJgQZczuYX
	p/HU2J2g5y4cbivCprlGrhu5oWnbJPTCXeIvlMsn0G9zZqqu9DeK/rqeeOHg0U9B6MAurt1a6WU
	mQzbiwR6rSAi+
X-Received: by 2002:a05:600c:310b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-4562e29c33emr210945245e9.29.1753195192089;
        Tue, 22 Jul 2025 07:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiFVJztAJAsGCwFkVWQjDHWa5km7SIwfTibnU0fsbIHs3oWXWzepmUGBqcNc5EYazTcDWqmA==
X-Received: by 2002:a05:600c:310b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-4562e29c33emr210944865e9.29.1753195191605;
        Tue, 22 Jul 2025 07:39:51 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm196183095e9.23.2025.07.22.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:39:51 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:39:49 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>
cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    jackabt@amazon.com
Subject: Re: [PATCH] KVM: arm64: selftest: Add standalone test checking for
 KVM's own UUID
In-Reply-To: <20250721155136.892255-1-maz@kernel.org>
Message-ID: <aa2bbb09-c9bb-100e-b4dd-a3010c8458eb@redhat.com>
References: <20250721155136.892255-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 21 Jul 2025, Marc Zyngier wrote:
> Tinkering with UUIDs is a perilious task, and the KVM UUID gets
> broken at times. In order to spot this early enough, add a selftest
> that will shout if the expected value isn't found.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20250721130558.50823-1-jackabt.amazon@gmail.com

Reviewed-by: Sebastian Ott <sebott@redhat.com>


