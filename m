Return-Path: <linux-kernel+bounces-864092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1014BF9E20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444454F1B35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023A2D47FF;
	Wed, 22 Oct 2025 03:56:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F198199BC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105390; cv=none; b=fus7PJmA7/a7ne6FOecm1QEa2W92OdiFMs7ApbSN4vxUI6HQtgJnOJYK5700+0bUuNpeslhVpmWKaE7zCzTVscoL87DYcr0tbWGeLLbpgPtIHnMf9bz0Re3xZFQA+Cm/qS174i7KYIYb0t9T/4iucWoWp9PXotTDxzC0OUI5C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105390; c=relaxed/simple;
	bh=DJwnPiC4EHfyoq4dOzSQa4wDxe626aQv/yu+P9NDTMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aNYmvrYd/PFZm8Ley4Dzpgsby3iDRH9ZnfQhlUdJ3VQ3yuXh4pz4o4puI+uHZUQ0j2VbndqwVYZaozQDbQWzdfVVisYXMrYHne7SXq3zsY7CyOls69jtMjDdVYYiUDxPcyGQyY43rCFIjh0+GqYbwiWgNXNga93y+qTRmS9C1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20CC1063;
	Tue, 21 Oct 2025 20:56:19 -0700 (PDT)
Received: from [10.163.68.114] (unknown [10.163.68.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81B33F66E;
	Tue, 21 Oct 2025 20:56:23 -0700 (PDT)
Message-ID: <873b6b5a-1c44-4cfd-a36e-adaa171077b8@arm.com>
Date: Wed, 22 Oct 2025 09:26:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: Fix indentation in fold_diff function.
To: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 jinnasujing@gmail.com
References: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/10/25 1:07 pm, Jing Su wrote:
> Adjust misaligned braces in the fold_diff function to improve
> code readability and maintain consistent coding style.
>
> Signed-off-by: Jing Su <jingsusu@didiglobal.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>
  
  


