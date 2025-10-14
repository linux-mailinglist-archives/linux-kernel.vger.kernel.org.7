Return-Path: <linux-kernel+bounces-852395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF4BD8DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933381924D05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3C2FD7DD;
	Tue, 14 Oct 2025 10:58:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28552FC02A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439526; cv=none; b=XsM0wQhrJwqAvw2krGKoJQS94FH/Dj/xMuFdk/b5T4O1xnOm77fKLgZVk8yWge8/ZOLL7ViJT/WthV6nhB3YhIYB3fSWCCbGbn8LzyDk7IO/bfKWlyWuiLGqBvQylhYjWOW7ijiWBpLRx3sw65l/Bnf+BjWbGIe+S19IcRrGgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439526; c=relaxed/simple;
	bh=5tNUuCR4d0x4dSOsBZuY8Z7tzYB72pjxRgcXhTJ+YHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngQB0I2/4g5GZSihOvpK2RDmq7hKQUMUlanjjI4vB5UwGE0gBmWIHGB4rJEuwijmoDIkOIDIn92F+k3Mxictbw43672CbfY6UeEUvbKIESiGsktOZ5BuoirOXEDv/zXhtVm32UkIoFLc07/ikS0mbRRXFKN+ftTQMtUDqfqzwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448FB1A9A;
	Tue, 14 Oct 2025 03:58:35 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC893F66E;
	Tue, 14 Oct 2025 03:58:41 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:58:37 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Vedashree Vidwans <vvidwans@nvidia.com>
Cc: Salman Nabi <salman.nabi@arm.com>, <lpieralisi@kernel.org>,
 <mark.rutland@arm.com>, <sudeep.holla@arm.com>, <ardb@kernel.org>,
 <chao.gao@intel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <sdonthineni@nvidia.com>, <vsethi@nvidia.com>, <vwadekar@nvidia.com>
Subject: Re: [RFC PATCH 2/3] firmware: smccc: LFA: refactor, add device node
 support
Message-ID: <20251014115837.4ad17e38@donnerap.manchester.arm.com>
In-Reply-To: <b0a1c2ab-c040-41cb-9dad-49442a03993b@nvidia.com>
References: <20251008190907.181412-1-vvidwans@nvidia.com>
	<20251008190907.181412-3-vvidwans@nvidia.com>
	<12598032-3f12-42db-8fc9-6ef879d9a3ba@arm.com>
	<b0a1c2ab-c040-41cb-9dad-49442a03993b@nvidia.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 13:47:33 -0700
Vedashree Vidwans <vvidwans@nvidia.com> wrote:

Hi Veda,

> On 10/10/25 10:35, Salman Nabi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hi Vedashree,
> > 
> > Thank you for sending those pathces over. I just have a few comments.
> > 
> > On 10/8/25 20:09, Vedashree Vidwans wrote:  
> >> - Add support for LFA device node in the kernel driver. Implement
> >> probe() to register LFA interrupt and threaded interrupt service
> >> function.
> >> - CPUs will be rendezvoused during activation.
> >> - On IRQ, driver will query FW components then triggers activation of
> >> capable and pending components.
> >> - Mutex synchronization is implemented to avoid concurrent LFA updates
> >> through interrupt and sysfs interfaces.
> >> - Refactor LFA CANCEL logic into independent lfa_cancel() function.
> >> - Enhance PRIME/ACTIVATION functions to touch watchdog and implement
> >> timeouts.
> >>
> >> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
> >> ---
> >>   drivers/firmware/smccc/lfa_fw.c | 299 ++++++++++++++++++++++++++++----
> >>   1 file changed, 262 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
> >> index 49f7feb6a211b..b36b8d7457c30 100644
> >> --- a/drivers/firmware/smccc/lfa_fw.c
> >> +++ b/drivers/firmware/smccc/lfa_fw.c
> >> @@ -16,7 +16,15 @@
> >>   #include <linux/uuid.h>
> >>   #include <linux/array_size.h>
> >>   #include <linux/list.h>
> >> -
> >> +#include <linux/interrupt.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/acpi.h>
> >> +#include <linux/nmi.h>
> >> +#include <linux/ktime.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/mutex.h>
> >> +
> >> +#define DRIVER_NAME  "ARM_LFA"
> >>   #define LFA_ERROR_STRING(name) \
> >>        [name] = #name
> >>   #undef pr_fmt
> >> @@ -34,6 +42,18 @@
> >>   #define LFA_1_0_FN_ACTIVATE          LFA_1_0_FN(5)
> >>   #define LFA_1_0_FN_CANCEL            LFA_1_0_FN(6)
> >>
> >> +/* CALL_AGAIN flags (returned in res.a1[0]) */
> >> +#define LFA_PRIME_CALL_AGAIN         BIT(0)
> >> +#define LFA_ACTIVATE_CALL_AGAIN              BIT(0)
> >> +
> >> +/* Prime loop limits, TODO: tune after testing */
> >> +#define LFA_PRIME_BUDGET_US          30000000 /* 30s cap */
> >> +#define LFA_PRIME_POLL_DELAY_US              10       /* 10us between polls */
> >> +
> >> +/* Activation loop limits, TODO: tune after testing */
> >> +#define LFA_ACTIVATE_BUDGET_US               20000000 /* 20s cap */
> >> +#define LFA_ACTIVATE_POLL_DELAY_US   10       /* 10us between polls */
> >> +
> >>   /* LFA return values */
> >>   #define LFA_SUCCESS                  0
> >>   #define LFA_NOT_SUPPORTED            1
> >> @@ -114,8 +134,9 @@ static const struct fw_image_uuid {
> >>   };
> >>
> >>   static struct kobject *lfa_dir;
> >> +static DEFINE_MUTEX(lfa_lock);
> >>
> >> -static int get_nr_lfa_components(void)
> >> +static unsigned long get_nr_lfa_components(void)
> >>   {
> >>        struct arm_smccc_1_2_regs args = { 0 };
> >>        struct arm_smccc_1_2_regs res = { 0 };
> >> @@ -130,11 +151,40 @@ static int get_nr_lfa_components(void)
> >>        return res.a1;
> >>   }
> >>
> >> +static int lfa_cancel(void *data)
> >> +{
> >> +     struct image_props *attrs = data;
> >> +     struct arm_smccc_1_2_regs args = { 0 };
> >> +     struct arm_smccc_1_2_regs res = { 0 };
> >> +
> >> +     args.a0 = LFA_1_0_FN_CANCEL;
> >> +     args.a1 = attrs->fw_seq_id;
> >> +     arm_smccc_1_2_invoke(&args, &res);
> >> +
> >> +     /*
> >> +      * When firmware activation is called with "skip_cpu_rendezvous=1",
> >> +      * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
> >> +      * cancelled.
> >> +      */
> >> +     if (res.a0 == LFA_SUCCESS) {
> >> +             pr_info("Activation cancelled for image %s",
> >> +                     attrs->image_name);
> >> +     } else {
> >> +             pr_err("Firmware activation could not be cancelled: %ld",
> >> +                    (long)res.a0);
> >> +             return -EIO;
> >> +     }
> >> +
> >> +     return res.a0;
> >> +}
> >> +
> >>   static int call_lfa_activate(void *data)
> >>   {
> >>        struct image_props *attrs = data;
> >>        struct arm_smccc_1_2_regs args = { 0 };
> >>        struct arm_smccc_1_2_regs res = { 0 };
> >> +     ktime_t end = ktime_add_us(ktime_get(), LFA_ACTIVATE_BUDGET_US);
> >> +     int ret;
> >>
> >>        args.a0 = LFA_1_0_FN_ACTIVATE;
> >>        args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
> >> @@ -148,9 +198,32 @@ static int call_lfa_activate(void *data)
> >>         */
> >>        args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
> >>
> >> -     do {
> >> +     for (;;) {
> >> +             /* Touch watchdog, ACTIVATE shouldn't take longer than watchdog_thresh */
> >> +             touch_nmi_watchdog();
> >>                arm_smccc_1_2_invoke(&args, &res);
> >> -     } while (res.a0 == 0 && res.a1 == 1);
> >> +
> >> +             if ((long)res.a0 < 0) {
> >> +                     pr_err("ACTIVATE for image %s failed: %s",
> >> +                             attrs->image_name, lfa_error_strings[-res.a0]);
> >> +                     return res.a0;
> >> +             }
> >> +             if (!(res.a1 & LFA_ACTIVATE_CALL_AGAIN))
> >> +                     break; /* ACTIVATE successful */
> >> +
> >> +             /* SMC returned with call_again flag set */
> >> +             if (ktime_before(ktime_get(), end)) {
> >> +                     udelay(LFA_ACTIVATE_POLL_DELAY_US);
> >> +                     continue;
> >> +             }
> >> +
> >> +             pr_err("ACTIVATE timed out for image %s", attrs->image_name);
> >> +             ret = lfa_cancel(attrs);
> >> +             if (ret == 0)
> >> +                     return -ETIMEDOUT;
> >> +             else
> >> +                     return ret;
> >> +     }
> >>
> >>        return res.a0;
> >>   }
> >> @@ -159,8 +232,24 @@ static int activate_fw_image(struct image_props *attrs)
> >>   {
> >>        struct arm_smccc_1_2_regs args = { 0 };
> >>        struct arm_smccc_1_2_regs res = { 0 };
> >> +     ktime_t end = ktime_add_us(ktime_get(), LFA_PRIME_BUDGET_US);
> >>        int ret;
> >>
> >> +     if (attrs->may_reset_cpu) {
> >> +             pr_err("Firmware component requires unsupported CPU reset");
> >> +             return -EINVAL;
> >> +     }
> >> +
> >> +     /*
> >> +      * We want to force CPU rendezvous if either cpu_rendezvous or
> >> +      * cpu_rendezvous_forced is set. The flag value is flipped as
> >> +      * it is called skip_cpu_rendezvous in the spec.
> >> +      */
> >> +     if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
> >> +             pr_warn("CPU rendezvous is expected to be selected.");
> >> +             return -EAGAIN;
> >> +     }  
> > 
> > The purpose of cpu_rendezvous_forced was to allow firmware components, that dont
> > require cpu rendezvous, bypass kernel's conservative approach of always requiring
> > cpu_rendezvous. This was per the feedback on the first LFA RFC patch. If we are
> > happy forcing cpu rendezvou than I don't see the point of cpu_rendezvous_forced
> > switch.
> >   
> For current situation, enforcing CPU rendezvous appears to be the most 
> practical approach for our usecase. I agree that cpu_rendezvous_forced 
> switch is redundant but it enforces the situation that kernel can handle.
>  From my perspective, it is challenging for kernel driver to reliably 
> determine whether any process will use services from the firmware that's 
> being updated. We should revisit whether the switch is necessary in the 
> future, especially based on requirements, feedback and validation data.

I completely agree that using the CPU rendezvous is the safest option from
the kernel side, but we also got feedback that it's not acceptable to
enforce this for *every* firmware component, as gathering hundreds of
cores just for updating some board controller firmware that does not
provide a kernel interface is not helpful.
Hence we deliberately introduced the cpu_rendezvous_forced file, which
defaults to 1, so out of the box you get the CPU rendezvous behaviour. But
it allows a system administrator to opt out of the rendezvous, just for
this particular firmware component, based on knowledge that the kernel
will be fine. It's kind of a "I know what I am doing" switch, so it's the
admin's responsibility when they screw up the machine in the process.

Cheers,
Andre

>> +
> >>        /*
> >>         * LFA_PRIME/ACTIVATE will return 1 in res.a1 if the firmware
> >>         * priming/activation is still in progress. In that case
> >> @@ -169,20 +258,36 @@ static int activate_fw_image(struct image_props *attrs)
> >>         */
> >>        args.a0 = LFA_1_0_FN_PRIME;
> >>        args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
> >> -     do {
> >> +     for (;;) {
> >> +             /* Touch watchdog, PRIME shouldn't take longer than watchdog_thresh */
> >> +             touch_nmi_watchdog();
> >>                arm_smccc_1_2_invoke(&args, &res);
> >> -             if (res.a0 != LFA_SUCCESS) {
> >> -                     pr_err("LFA_PRIME failed: %s\n",
> >> -                             lfa_error_strings[-res.a0]);
> >>
> >> +             if ((long)res.a0 < 0) {
> >> +                     pr_err("LFA_PRIME for image %s failed: %s\n",
> >> +                             attrs->image_name, lfa_error_strings[-res.a0]);
> >>                        return res.a0;
> >>                }
> >> -     } while (res.a1 == 1);
> >> +             if (!(res.a1 & LFA_PRIME_CALL_AGAIN))
> >> +                     break; /* PRIME successful */
> >>
> >> -     if (attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)
> >> -             ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
> >> -     else
> >> -             ret = call_lfa_activate(attrs);
> >> +             /* SMC returned with call_again flag set */
> >> +             if (ktime_before(ktime_get(), end)) {
> >> +                     udelay(LFA_PRIME_POLL_DELAY_US);
> >> +                     continue;
> >> +             }
> >> +
> >> +             pr_err("PRIME timed out for image %s", attrs->image_name);
> >> +             ret = lfa_cancel(attrs);
> >> +             if (ret == 0)
> >> +                     return -ETIMEDOUT;
> >> +             else
> >> +                     return ret;
> >> +     }
> >> +
> >> +     ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
> >> +     if (ret != 0)
> >> +             return lfa_cancel(attrs);
> >>
> >>        return ret;
> >>   }
> >> @@ -286,23 +391,23 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
> >>                                         image_attrs[LFA_ATTR_ACTIVATE]);
> >>        int ret;
> >>
> >> -     if (attrs->may_reset_cpu) {
> >> -             pr_err("Firmware component requires unsupported CPU reset\n");
> >> -
> >> -             return -EINVAL;
> >> +     if (!mutex_trylock(&lfa_lock)) {
> >> +             pr_err("Mutex locked, try again");
> >> +             return -EAGAIN;
> >>        }
> >>
> >>        ret = activate_fw_image(attrs);
> >>        if (ret) {
> >>                pr_err("Firmware activation failed: %s\n",
> >>                        lfa_error_strings[-ret]);
> >> -
> >> +             mutex_unlock(&lfa_lock);
> >>                return -ECANCELED;
> >>        }
> >>
> >>        pr_info("Firmware activation succeeded\n");
> >>
> >>        /* TODO: refresh image flags here*/
> >> +     mutex_unlock(&lfa_lock);
> >>        return count;
> >>   }
> >>
> >> @@ -311,26 +416,11 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
> >>   {
> >>        struct image_props *attrs = container_of(attr, struct image_props,
> >>                                                 image_attrs[LFA_ATTR_CANCEL]);
> >> -     struct arm_smccc_1_2_regs args = { 0 };
> >> -     struct arm_smccc_1_2_regs res = { 0 };
> >> -
> >> -     args.a0 = LFA_1_0_FN_CANCEL;
> >> -     args.a1 = attrs->fw_seq_id;
> >> -     arm_smccc_1_2_invoke(&args, &res);
> >> +     int ret;
> >>
> >> -     /*
> >> -      * When firmware activation is called with "skip_cpu_rendezvous=1",
> >> -      * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
> >> -      * cancelled.
> >> -      */
> >> -     if (res.a0 == LFA_SUCCESS) {
> >> -             pr_info("Activation cancelled for image %s\n",
> >> -                     attrs->image_name);
> >> -     } else {
> >> -             pr_err("Firmware activation could not be cancelled: %s\n",
> >> -                    lfa_error_strings[-res.a0]);
> >> -             return -EINVAL;
> >> -     }
> >> +     ret = lfa_cancel(attrs);
> >> +     if (ret != 0)
> >> +             return ret;
> >>
> >>        return count;
> >>   }
> >> @@ -418,6 +508,11 @@ static int create_fw_images_tree(void)
> >>        int ret, num_of_components;
> >>
> >>        num_of_components = get_nr_lfa_components();
> >> +     if (num_of_components <= 0) {
> >> +             pr_err("Error getting number of LFA components");
> >> +             return -ENODEV;
> >> +     }
> >> +
> >>        args.a0 = LFA_1_0_FN_GET_INVENTORY;
> >>        for (int i = 0; i < num_of_components; i++) {
> >>                args.a1 = i; /* fw_seq_id under consideration */
> >> @@ -437,6 +532,125 @@ static int create_fw_images_tree(void)
> >>        return 0;
> >>   }
> >>
> >> +static int refresh_fw_images_tree(void)
> >> +{
> >> +     int ret;
> >> +     /*
> >> +      * Ideally, this function should invoke the GET_INVENTORY SMC
> >> +      * for each firmware image and update the corresponding details
> >> +      * in the firmware image tree node.
> >> +      * There are several edge cases to consider:
> >> +      *    - The number of firmware components may change.
> >> +      *    - The mapping between firmware sequence IDs and
> >> +      *      firmware image UUIDs may be modified.
> >> +      * As a result, it is possible that the firmware image tree nodes
> >> +      * will require updates. Additionally, GET_INVENTORY SMC provides
> >> +      * all current and revised information. Therefore, retaining the
> >> +      * existing fw_images_tree data is not justified. Reconstructing
> >> +      * the firmware images tree will simplify the code and keep data
> >> +      * up-to-date.
> >> +      */
> >> +     // Clean current inventory details
> >> +     clean_fw_images_tree();  
> > 
> > This isn't an optimal approach to updating the firmware components. Removing a
> > directory that a user is currently looking at will still linger around as its
> > ref count won't get 0. Also, an attribute read/write operation during an
> > activation for example, reading the activation pending flag will result in
> > the mutex lock waiting to acquire the lock which will keep the attribute file
> > around. Trying to remove said object may result in unpredictable behaviour.
> > We have a WIP patch that is supposed to refresh the data i.e. firmware images
> > attributes and seq_ids, instead of deleting the objects and re-creating them.
> > Only firmware images that are removed from the LFA agent following an
> > activation would be removed.
> >   
> Okay, I understand.
> I will add a placeholder to refresh the fw_images_tree() to unblock rest 
> of the changes. I will hold back to use your implementation and/or 
> brainstorm more approaches in parallel.>> +
> >> +     // Update new inventory details
> >> +     ret = create_fw_images_tree();
> >> +     if (ret != 0)
> >> +             kobject_put(lfa_dir);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static irqreturn_t lfa_irq_thread(int irq, void *data)
> >> +{
> >> +     struct image_props *attrs = NULL;
> >> +     int ret;
> >> +
> >> +     mutex_lock(&lfa_lock);  
> > 
> > mutex_lock() can sleep and is unsafe in an interrupt context, mutex_trylock()
> > doesn't sleep but is still considered illegal in an interrupt context as
> > mutex_unlock() can still sleep.
> >   
> The lfa_irq_thread() is a thread_fn passed to request_threaded_irq(). 
>  From what I understand, thread_fn runs in a process context as a kernel 
> thread and therefore can use sleeping locks such as mutex_lock(), 
> wait_event() and msleep().>> +
> >> +     // Update new inventory details
> >> +     ret = refresh_fw_images_tree();  
> > 
> > According to the LFA specification IIRC the firmware images and their seq_ids
> > may change following an activation, not after an update that is pending an
> > activation. Thus the refresh should happen soon after an activation only.
> > 
> > Kind Regards
> > Salman
> >   
> Thank you for pointing that out. If I understand the spec correctly, it 
> is possible that number of components can change after an activation and 
> so we would have to refresh complete fw_images_tree.
> So the flow I would follow for activation is:
> 1. Get inventory for all FW components
> 2. PRIME-ACTIVATE first activable component in the list.
> 3. Go to 1, until no component is pending activation.
> 
> Regards,
> Veda>> +     if (ret != 0)
> >> +             goto exit_unlock;
> >> +
> >> +     /*
> >> +      * Execute PRIME and ACTIVATE for each FW component
> >> +      * Start from first FW component
> >> +      */
> >> +     list_for_each_entry(attrs, &lfa_fw_images, image_node) {
> >> +             if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
> >> +                     /* LFA not applicable for this FW component, continue to next component */
> >> +                     continue;
> >> +             }
> >> +
> >> +             ret = activate_fw_image(attrs);
> >> +             if (ret) {
> >> +                     pr_err("Firmware %s activation failed: %s\n",
> >> +                             attrs->image_name, lfa_error_strings[-ret]);
> >> +                     goto exit_unlock;
> >> +             }
> >> +
> >> +             pr_info("Firmware %s activation succeeded", attrs->image_name);
> >> +     }
> >> +
> >> +     // Update new inventory details
> >> +     ret = refresh_fw_images_tree();
> >> +     if (ret != 0)
> >> +             goto exit_unlock;
> >> +
> >> +exit_unlock:
> >> +     mutex_unlock(&lfa_lock);
> >> +     return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int __init lfa_probe(struct platform_device *pdev)
> >> +{
> >> +     int err;
> >> +     unsigned int irq;
> >> +
> >> +     err = platform_get_irq_byname_optional(pdev, "fw-store-updated-interrupt");
> >> +     if (err < 0)
> >> +             err = platform_get_irq(pdev, 0);
> >> +     if (err < 0) {
> >> +             pr_err("Interrupt not found, functionality will be unavailable.");
> >> +
> >> +             /* Bail out without failing the driver. */
> >> +             return 0;
> >> +     }
> >> +     irq = err;
> >> +
> >> +     err = request_threaded_irq(irq, NULL, lfa_irq_thread, IRQF_ONESHOT, DRIVER_NAME, NULL);
> >> +     if (err != 0) {
> >> +             pr_err("Interrupt setup failed, functionality will be unavailable.");
> >> +
> >> +             /* Bail out without failing the driver. */
> >> +             return 0;
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct of_device_id lfa_of_ids[] = {
> >> +     { .compatible = "arm,armhf000", },
> >> +     { },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, lfa_of_ids);
> >> +
> >> +static const struct acpi_device_id lfa_acpi_ids[] = {
> >> +     {"ARMHF000"},
> >> +     {},
> >> +};
> >> +MODULE_DEVICE_TABLE(acpi, lfa_acpi_ids);
> >> +
> >> +static struct platform_driver lfa_driver = {
> >> +     .probe = lfa_probe,
> >> +     .driver = {
> >> +             .name = DRIVER_NAME,
> >> +             .of_match_table = lfa_of_ids,
> >> +             .acpi_match_table = ACPI_PTR(lfa_acpi_ids),
> >> +     },
> >> +};
> >> +
> >>   static int __init lfa_init(void)
> >>   {
> >>        struct arm_smccc_1_2_regs args = { 0 };
> >> @@ -464,22 +678,33 @@ static int __init lfa_init(void)
> >>        pr_info("Arm Live Firmware Activation (LFA): detected v%ld.%ld\n",
> >>                res.a0 >> 16, res.a0 & 0xffff);
> >>
> >> +     err = platform_driver_register(&lfa_driver);
> >> +     if (err < 0)
> >> +             pr_err("Platform driver register failed");
> >> +
> >> +
> >>        lfa_dir = kobject_create_and_add("lfa", firmware_kobj);
> >>        if (!lfa_dir)
> >>                return -ENOMEM;
> >>
> >> +     mutex_lock(&lfa_lock);
> >>        err = create_fw_images_tree();
> >>        if (err != 0)
> >>                kobject_put(lfa_dir);
> >>
> >> +     mutex_unlock(&lfa_lock);
> >>        return err;
> >>   }
> >>   module_init(lfa_init);
> >>
> >>   static void __exit lfa_exit(void)
> >>   {
> >> +     mutex_lock(&lfa_lock);
> >>        clean_fw_images_tree();
> >> +     mutex_unlock(&lfa_lock);
> >> +
> >>        kobject_put(lfa_dir);
> >> +     platform_driver_unregister(&lfa_driver);
> >>   }
> >>   module_exit(lfa_exit);
> >>  
> 


