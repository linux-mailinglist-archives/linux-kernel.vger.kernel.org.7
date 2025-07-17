Return-Path: <linux-kernel+bounces-735634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F20B091E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB04D4A0AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685302F85FA;
	Thu, 17 Jul 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJTn6+hu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F7204F8B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769953; cv=none; b=Gi9iiVCEFPJl4tjLlYVoB3fR14uAP0md7qOjG2nFh6yqykrQ6r7kTolB7sGT0V4ZkF144pumwNccQ7ohzMD1ngX+swGwHJ51fhqDcBxgOJz+eYC/KU7wRrKKaRX7e+gb4r5fkGq5Jt8PNcJPa26Tf80pt1uoQAXHUji53A6rojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769953; c=relaxed/simple;
	bh=qJWeJvcAEmId2TBWbTVt2UezmvAUILmSaTVbsvihvzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5fI/X6WUSLJrXcuWG0xOMwI5szJCJq0Q2Jm5bI6UMgrSFD7jZH5k/KMMgliHio6K2zXwc52nT8tkl+2ji5S/RSaVSiVJKHBF0YDAAuCXL9eICfk4I7n86uDCPj09Fs4S3AXUnbrJIDsWbXffQg80q6y/+6HW36hyb7VtZaIAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJTn6+hu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752769951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJWeJvcAEmId2TBWbTVt2UezmvAUILmSaTVbsvihvzA=;
	b=HJTn6+huxnqzaYydiWw/iJIDy3sWWfw71nggaYmZBoTfzXs1n8MLR/ZCUXYGrFmeW6Lx0a
	3VKESx1ZveO09gs/XsADtQ5u3F1sqyhrN16Ft+u2qwzpTuKwWnLx8wxSnfLgoSlkm8aqF0
	D5p8GJ7AhFN/w5TjBAbQVTSIBvUkJYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-auFyNhBAObK5DfYKDuqmtA-1; Thu, 17 Jul 2025 12:32:29 -0400
X-MC-Unique: auFyNhBAObK5DfYKDuqmtA-1
X-Mimecast-MFC-AGG-ID: auFyNhBAObK5DfYKDuqmtA_1752769948
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so6136255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769948; x=1753374748;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJWeJvcAEmId2TBWbTVt2UezmvAUILmSaTVbsvihvzA=;
        b=uqZgzCiR96cC9KpP99nrsqlt66BCN9U6iOe50xyWaCwlQ3qVnjRuthOMohk9EhQWtq
         H29q3D3AbtQBgVz/5K9nWNWQ4cSY6wnRtzjv/t8Q0cmOgxZf7itGlBkf7wjQLaQnBIXv
         SjsUEdPDRlxg2XUSjsJmKtsXPTOK4n5IgmadrJesIa5/xefOVRghFlKmXP6DgmyOZY+4
         uAQUAGssDjPM4f1lRCXt3cAQowyNqZeU+ULjOabI1qKbs9e6X1SbdrHFLrbgSwf+JMp5
         2+VlcW8GGdRu+1WdREVOt3XQjnOLaOWypvcjmzTGjov5U21x6JHnbG36+SR0pKd/gAPU
         GfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwsczcadax5VOODf0Y9mV9Ynjp3X0rnU9ekq8v6C2JDBbfd5gdVH6Kd/N74LdQdmDTfcs5wChET1BAgXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6bTqoUvwE3Thcf9Gw6Cv/rGOC6W1cVcsrq9bOs0xEX6/rZV5
	/zPqKsA1JkEY42DxJQ7jP5p7L7+Uflxn8AECDeIQZIWqegpJuUCwrQS0SENKfqWOpzDzZR4aH43
	xI2c8jI/PjxQvvhHPn2nfkjAnwFXc1qJoQu5tU0tili+ALLjsQlsST3kOLbHY7UBS5w==
X-Gm-Gg: ASbGncsUEdbAGdsVelTYgq1u71yqSEiiHBkJK50x75/0DU8MElEB6dXidkYs2RrL00o
	Y9p7r5fZ3HhzDC2bG5hNs6ezwy4H4c/n9U+KpDgtuzgdK0HNdqFAnaL/cEUuiRTNViTCzML9IRL
	CHDfbvLUmONeJ8dDppSLSO5VUr96wzVKXBxCUZrKIaOhM0ha6ovP26Lhw4MlxmeL9zFQ2tsSSvN
	lhEJGHv6qo4jFbkhOXXVPRXK2eZ1eW3fMoSSgLGyY6OuldUbdOtv6+QDy2n+KbFCdFCU2mqLrjl
	POzBn0aW24Z0YfjfQcze1R//TvWtoCOZ3PD9WRbaNz3k/NRMwIJCKbPMzfU0zdQCK6K2ZxJ4q6D
	STThPLpCdx8lPFX6SO34K38LO
X-Received: by 2002:a05:6000:43c7:20b0:3b6:136d:c290 with SMTP id ffacd0b85a97d-3b6136dc2a3mr2982319f8f.45.1752769948484;
        Thu, 17 Jul 2025 09:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQzGxJhe3gIkSoIMV12g4Kcm71GrJXuB1+ceh/DGol9qsj17VzPLGBT0wXyG++hQMd2pNnVw==
X-Received: by 2002:a05:6000:43c7:20b0:3b6:136d:c290 with SMTP id ffacd0b85a97d-3b6136dc2a3mr2982299f8f.45.1752769948105;
        Thu, 17 Jul 2025 09:32:28 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm21119219f8f.36.2025.07.17.09.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:32:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
Subject: Re: [PATCH 4/6] tick/nohz: Move nohz_full related fields out of hot
 task struct's places
In-Reply-To: <20250703140717.25703-5-frederic@kernel.org>
References: <20250703140717.25703-1-frederic@kernel.org>
 <20250703140717.25703-5-frederic@kernel.org>
Date: Thu, 17 Jul 2025 18:32:26 +0200
Message-ID: <xhsmh4ivag4md.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/07/25 16:07, Frederic Weisbecker wrote:
> nohz_full is a feature that only fits into rare and very corner cases.
> Yet distros enable it by default and therefore the related fields are
> always reserved in the task struct.
>
> Those task fields are stored in the middle of cacheline hot places such
> as cputime accounting and context switch counting, which doesn't make
> any sense for a feature that is disabled most of the time.
>
> Move the nohz_full storage to colder places.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

task_struct is still a bloody maze to me, but AFAICT there's *at least one*
full non-optional cacheline - the signal handling faff - between cputime
accounting and this new location, so:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


