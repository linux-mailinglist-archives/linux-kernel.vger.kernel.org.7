Return-Path: <linux-kernel+bounces-847770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA3BCBA59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5490F4E3A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330C1E25F9;
	Fri, 10 Oct 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uptr4hgb"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3642049
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071267; cv=none; b=g8dXbe7/SP5Feh0nQaK15HIOqnX/dvobw370wFesHpA/kMxUJVDLQ2A+MLJ5/GTtcsXiW/6+fkeo3i/Ybfjh9e1oPR4TzHy+CbUGspQX+fLupU06LJ8ve7tbV6NTXS9+YvjghCZmkXtKRd/qmhLmQgx9mFkqbWPQoaoad5LbOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071267; c=relaxed/simple;
	bh=Svrst4sNWvZPM9ptRkVgFgBmuigM6Siiz8w5w3Sqplk=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=iQMyjJ7fdK3ONd3ydmVj/RUD0cdyn8KtJQgFD7RTZlGlhYQOLZ1VekjWLJvS0YTO1oVwhEDLRr0r3ZTpq8utrYHgJsXK6BcbeYiq+P9EHMT3cnqXoFFVcU/T4MHOA4mj3io521OGM6mMdA1v3atAvZsbeKh54Qcmga3PCsaKSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uptr4hgb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811fa91774so1454810b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760071265; x=1760676065; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=Uptr4hgbWf9KC/lGeAwlD4b9IcORSsWiO/Zy7KGmNDR7fEApXRqPqVJB1z7pfmbPi5
         +OHS/mt488SSnDDYxYLX2qCscAq+o3HP0LsPZp1Gtqljwt6hvvEdKIA5iYPkhVW9q+gf
         1CtUBp4e1qjx2SHrVPKcYZZ33lcztz029X1sqTfjO1wWtr05nb3Y7tgFq5XLic8nkQpG
         o7Z6y+Xf2wQZXHe9THUj5SZsF8To2Mhrb2WaLgQm1DTzwyC5CQ5o24wq6/knBFwEy7iO
         j8dnS8fIKuqVd2Yci0V0nPxd7oJeGPh3skeDjXhex2Ty03QxLUgovaXUwc2V1ZnwLFH3
         DBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760071265; x=1760676065;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=sMvxc7SCc6vxCXGG+1uToGg5NlQLypeXyzwVgFSUE4a0ifc+6sg/tjTe2i6Wzlmxy8
         t1ycL2sdVNRaC7g6cpJntyVgONOq1w337brNkz7oeI0Ksf7TSAQNh5eGDUhWagD1Dj5T
         X+m8RQYiuuXdxR0SE4VURLWzcxYtEIujLUSZdGbo7CPC4GeEr+U50pDpjo6cGAu7kPZI
         NPTgSQgxrM1TvyMQG4MfRIC+bFsmWmK62VdyMMfknxh/RbJFvj714TBFdjtJnZk+nEF3
         ev30jVvdBomSO4Ub7mP78+c8BAVX0o0kk+zFrz4V7vp8uPlTDB8pshhQ5DM9rx5TXve6
         NfPA==
X-Gm-Message-State: AOJu0YxS4n8sM5DS/HTK7fxZgL/agV+7lZKIg8oNxQVbryZnh/8JayWC
	BFJ0g1kR1gsggyx031BM5dhGl/Oi5d5sgm2KgdftAPAhf4b0wANinUTCeadX3A==
X-Gm-Gg: ASbGncv6hfYLzNoZRY9jY23I/q6xoU9dbwRmKhUaxhQOOEDk3PgNHg6zVONiw+LDGUX
	G1UM/RUwTia0dG2/BnAhkTVwCirzcv19r9mCJf0owtPgj5dTXplcFd1j2RvjVOrNIco0kZHk9hM
	eU0dUSKYMcRdPbN4C8d5mLhUFvgJ4oJsByhvhXt0qevzAPHcMfOMe6A9D5BUoeGgchMtjQfMthz
	UOhjfyVOvVqtg43dni5mkzA3IfpfhxbA26FgKRujjTx9YMbt9TI9EVe3OmMSyYT+FypiUxLzdLF
	0eVr2AfM6M38DXTXPdV3Ls8mgPRL1jHRJ9dcqyXJrHDR9Baw0PC08D67lCdXUcbfv6j9ERfVKHQ
	9f283Het90rX/TcHetIbSti3atvGmcktfD1cDxe8p6IYtpfN9UnBQti+/L0Uy5g2sNxCZQYQO0V
	EVIqvuv5ekH0vnTQFrVq+4cLd8kgkC
X-Google-Smtp-Source: AGHT+IHF8yPgwdAsvd2vyFO+gky4NWGzh9bWvo3muYfZw20/MXLHB2YqAqMzjvSKwxi8WOi78ci/rQ==
X-Received: by 2002:aa7:8896:0:b0:781:15d0:8848 with SMTP id d2e1a72fcca58-79385ddc7e9mr12944896b3a.13.1760071264416;
        Thu, 09 Oct 2025 21:41:04 -0700 (PDT)
Received: from ?IPv6:2409:40e3:2084:f4c4:99fd:d346:f152:46c7? ([2409:40e3:2084:f4c4:99fd:d346:f152:46c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993f7bsm1397179b3a.78.2025.10.09.21.41.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 21:41:04 -0700 (PDT)
From: Vimal Yadav <vy147591@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE:Appointment request
Message-ID: <f3eb122e-9b47-8b6d-91f4-6dc3a9806b46@gmail.com>
Date: Fri, 10 Oct 2025 10:10:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB

Hello there,

We did not hear back from you.

Can we schedule a call for Friday (10th october) or Monday (13th 
october) so we
can discuss Artificial Intelligence and Machine Learning requirements
you may have?

Kindly share your contact details and suggest a day/time for our call.

Thanks and regards
Vimal Yadav
Technical Solution Manager


On 28-07-2025 16:17, Vimal Yadav wrote:


Hello there,

Are you exploring ways to streamline operations, reduce costs, or
deliver smarter customer experiences?

We’re offering a free AI readiness consultation to help you identify
opportunities and create a roadmap tailored to your business.

Let’s talk about what AI and ML can actually do for your business.

Look forward to your response.

Thanks and regards
Vimal Yadav
Technical Solution Manager

