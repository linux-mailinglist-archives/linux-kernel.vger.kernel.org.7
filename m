Return-Path: <linux-kernel+bounces-814655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FAB556FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E73FA033B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57528725A;
	Fri, 12 Sep 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFpbx6+c"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329E29B76F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705851; cv=none; b=mtXC2d2TGmi/DeLycIpQDq3Mvz4QQAufF9ruspBHOdBOviLk+Bzz1hjvCiciIGtZWTI5/wjpK2lprRJy7vnk9uH/dyJM6D0UI+GVgs3mL45Pz25Bi5lG+gnA7ATbYZjM35OuPHYkNcpWAWm4FU5b6pqrSva0pA+dnqygl9FUGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705851; c=relaxed/simple;
	bh=jA4wqu8GiEeHtdnCeD5CK5KRYYjCmySD2Ig7LvqbLvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt4o30jMd/MLVjRkV6ldCQezOFjPQUdQgHdQDQj7R67ndigerrch4KgtyjFJns/KX2hfKv5Ay0liARLjsfi1BLt5fszkCJsEQjAg2f30dT25sI4Zz0tQq1lRu8bMgZJPu7Ed9uQN5Hx0w4pozEfNDLqj7hjPXZrHcsgbFweQC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kFpbx6+c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so696548a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757705849; x=1758310649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MG8qheklqH90QoillqEWtKlvYUOtiPcMmtaoD7S73Y0=;
        b=kFpbx6+cfRDl6zH/qqtuWqnqkT8z/4hnFljcCzE79tCabjdui23SUJLdYodCFlQSX2
         kz9mIeAJCHRcU64pWFatcJDddWtC6z4b7uluZ3K9kfhSmxqgvHdEfTGrAyKPXKWk0qM2
         yMg4450bEnmdaFAOAEl9/oh/icjMTKy+fpHzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757705849; x=1758310649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG8qheklqH90QoillqEWtKlvYUOtiPcMmtaoD7S73Y0=;
        b=llw45ECvCRlst8E/45t2FyPE26RyCGaLjHvtAsRmmsgI9ihVwh+cYZO5U8CdE2tGkB
         ke8B0Gbawk+RXJ3fT69WTTmYY5P2ToatxUyK6je/KNrXihNgbDnd3xd+qElIobaNWnHr
         BRz+Ha8IdWfZF/PzkUSj6VrquNK/uyDozKn9aZXqpQhrjOWsTeuqNHpSr71z4VAP9YTW
         GQagikmgd9Z/Q3kNeVmyJnTxz0WseW36J7Dk6En/ULx7KLifj+kJwUGT06785/hb1JAM
         I6R4wLZVyT6E7WacjHOPpn/qlVIY3XTxr7ZSC86NzlviIoruhe543Vwwt++pI1s7myPi
         3T1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFW+UjDewuSrg4Tl+VtwEPbfveFBhTco+E51I0C1txkd6IOyNpUb2GdhQUvcKtWAz06Vn63HrJ4k+UCdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOUDNY/cK6Raz1zXMkQg2z66ClNG2t6ZGOR9PhBZK+tgYnu00
	MZHskluIbMVer9+T4h+gvPZQLJq0GwFOg1ebGqtho7QRZZOKw05RrVmsLD4dlUO+MA==
X-Gm-Gg: ASbGncsH4+6rDvSDaKq8qEZYPl6vjrzJPt5FrFMbMkVtl4O8GPKb7GiTYpXUlTPQ/CK
	/iXg3eA+4m+t15/LBGZM6apgh8S9VN/SpB6NhFNaYtwz8PA69+65ZK1b/a11RyW/r45Y8M1+fSi
	e4qz4wXTN53a5jfesa6UJYwiTvXi2qyabf+8RVS8ewEZEqT+IuF42fiz12Yf7YvZWlJh04g0MLx
	fmXKduO/chLT/GuVy+E9thl6ePuzA18eY9lmBiMbnvdtPhYeLseJol7Dazbxogn6S0CcC+RMkup
	tDCtzA7OyuixRklPoyQ6qEqLBscLsZzSM56BoEvhJZ+/KQdrGiwpkyh3lIh0jmxrDH/hprl4zkE
	dhlzenPqj15c+v6rFTMFhrU86jzFuXGVvOcFczpkrZ2pKtE9GmHR/BgTHBXOds30S3QlBKg==
X-Google-Smtp-Source: AGHT+IEJWqu2QUfygF3YV1YBp/hXP59cBcFdW/VqJblCIvlUJMZ2WVhUCTFyXUdCNveV/J1mClgmeg==
X-Received: by 2002:a17:90b:1c87:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-32de4fa205bmr4591160a91.27.1757705849658;
        Fri, 12 Sep 2025 12:37:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dd61eaa27sm6985775a91.1.2025.09.12.12.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 12:37:28 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:37:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS
 clocks on Herobrine
Message-ID: <aMR2diG8zwvPRSXR@google.com>
References: <20250825155557.v2.1.I018984907c1e6322cf4710bd1ce805580ed33261@changeid>
 <20250825155557.v2.2.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
 <90b13660-1844-4701-8e63-7fde2f093db0@oss.qualcomm.com>
 <aMMcNn82AmSavJYf@google.com>
 <b51e1230-d366-4d0f-adc8-fac01b5de655@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51e1230-d366-4d0f-adc8-fac01b5de655@oss.qualcomm.com>

On Fri, Sep 12, 2025 at 03:10:16PM +0200, Konrad Dybcio wrote:
> As I attempt to find a board that would boot with your sw stack,
> could I ask you to check if commenting any of the three writes in
> 
> drivers/interconnect/qcom/icc-rpmh.c : qcom_icc_set_qos()
> 
> specifically causes the crash?
> 
> FWIW they're supposed to be independent so you don't have to test
> all possible combinations

It seems as if any one of them will cause the crash. I had to comment
out all 3 to avoid crashing.

Brian

